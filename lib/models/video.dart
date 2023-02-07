import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String uid;
  String username;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String videoName;
  String caption;
  String videoUrl;
  String profilePhoto;
  String thumbnail;

  Video({
    required this.uid,
    required this.username,
    required this.id,
    required this.likes,
    required this.shareCount,
    required this.commentCount,
    required this.videoUrl,
    required this.videoName,
    required this.caption,
    required this.profilePhoto,
    required this.thumbnail,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "uid": uid,
        "profilePhoto": profilePhoto,
        "id": id,
        "likes": likes,
        "commentCount": commentCount,
        "shareCount": shareCount,
        "videoName": videoName,
        "caption": caption,
        "videoUrl": videoUrl,
        "thumbnail": thumbnail,
      };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapShot = snap.data() as Map<String, dynamic>;

    return Video(
      uid: snapShot['uid'],
      username: snapShot['username'],
      id: snapShot['id'],
      likes: snapShot['likes'],
      shareCount: snapShot['shareCount'],
      commentCount: snapShot['commentCount'],
      videoUrl: snapShot['videoUrl'],
      videoName: snapShot['videoName'],
      caption: snapShot['caption'],
      profilePhoto: snapShot['profilePhoto'],
      thumbnail: snapShot['thumbnail'],
    );
  }
}
