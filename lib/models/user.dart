import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String username;
  String profilePhoto;
  String email;
  String uid;

  User({
    required this.username,
    required this.profilePhoto,
    required this.email,
    required this.uid,
  });

  Map<String, dynamic> toJson() => {
        "username": username,
        "profilePhoto": profilePhoto,
        "email": email,
        "uid": uid,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
        username: snapshot['username'],
        profilePhoto: snapshot['profilePhoto'],
        email: snapshot['email'],
        uid: snapshot['uid']);
  }
}
