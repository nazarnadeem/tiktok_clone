import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_clone/constants.dart';

import '../models/comment.dart';

class CommentController extends GetxController {
  final Rx<List<Comment>> _comments = Rx<List<Comment>>([]);
  List<Comment> get comments => _comments.value;

  String _postId = "";
  updatePostId(String id) {
    _postId = id;
    getComment();
  }

  getComment() async {
    _comments.bindStream(
      firebaseFirestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .snapshots()
          .map(
        (QuerySnapshot query) {
          List<Comment> returnValue = [];
          for (var element in query.docs) {
            returnValue.add(Comment.fromSnap(element));
          }
          return returnValue;
        },
      ),
    );
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot documentSnapshot = await firebaseFirestore
            .collection('users')
            .doc(authController.user.uid)
            .get();
        var allComments = await firebaseFirestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .get();

        int length = allComments.docs.length;

        Comment comment = Comment(
          username: (documentSnapshot.data()! as dynamic)['username'],
          comment: commentText.trim(),
          datePublished: DateTime.now(),
          likes: [],
          profilePhoto: (documentSnapshot.data()! as dynamic)['profilePhoto'],
          uid: authController.user.uid,
          id: 'Comment $length',
        );

        await firebaseFirestore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('Comment $length')
            .set(
              comment.toJson(),
            );
        DocumentSnapshot doc =
            await firebaseFirestore.collection('videos').doc(_postId).get();
        firebaseFirestore.collection('videos').doc(_postId).update({
          'commentCount': (doc.data()! as dynamic)['commentCount'] + 1,
        });
      }
    } catch (e) {
      Get.snackbar(
        'Error while Commenting',
        e.toString(),
      );
    }
  }

  likeComment(String id) async {
    var uid = authController.user.uid;
    DocumentSnapshot documentSnapshot = await firebaseFirestore
        .collection('videos')
        .doc(_postId)
        .collection('comments')
        .doc(id)
        .get();
    if ((documentSnapshot.data()! as dynamic)['likes'].contains(uid)) {
      await firebaseFirestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayRemove([uid]),
      });
    } else {
      await firebaseFirestore
          .collection('videos')
          .doc(_postId)
          .collection('comments')
          .doc(id)
          .update({
        'likes': FieldValue.arrayUnion([uid]),
      });
    }
  }
}
