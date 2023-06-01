import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String email;
  final String username;
  final String uid;
  final String photoUrl;
  final String fullname;
  final String bio;
  final List followers;
  final List following;

  const User({
    required this.email,
    required this.username,
    required this.uid,
    required this.photoUrl,
    required this.fullname,
    required this.bio,
    required this.followers,
    required this.following,
  });

  Map<String, dynamic> toJson() => {
        "email": email,
        "username": username,
        "uid": uid,
        'photoUrl': photoUrl,
        "fullname": fullname,
        "followers": followers,
        "bio": bio,
        "following": following,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;
    return User(
      email: snapshot['email'],
      username: snapshot['username'],
      uid: snapshot['uid'],
      photoUrl: snapshot['photoUrl'],
      fullname: snapshot['fullname'],
      bio: snapshot['bio'],
      followers: snapshot['followers'],
      following: ['following'],
    );
  }
}
