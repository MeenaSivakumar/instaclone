import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String email;
  final String name;
  final String bio;
  final String photoUrl;
  final List followers;
  final List following;
  final String password;

  const User({
    required this.uid,
    required this.email,
    required this.name,
    required this.bio,
    required this.photoUrl,
    required this.followers,
    required this.following,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'username': name,
        'uid': uid,
        'email': email,
        'photourl': photoUrl,
        'bio': bio,
        'followers': followers,
        'following': following,
        'password': password,
      };

  static User fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return User(
        uid: snapshot['uid'] ?? '',
        email: snapshot['email'] ?? '',
        name: snapshot['username'] ?? '',
        bio: snapshot['bio'] ?? '',
        photoUrl: snapshot['photourl'] ?? '',
        followers: snapshot['followers'] ?? [],
        following: snapshot['following'] ?? [],
        password: snapshot['password'] ?? '');
  }
}
