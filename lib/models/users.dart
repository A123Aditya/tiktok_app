import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  String name;
  String profileImage;
  String email;
  String uid;
  User({
    required this.name,
    required this.email,
    required this.uid,
    required this.profileImage,
  });

  Map<String , dynamic> toJson() => {
    "name" : name,
    "profileImage" : profileImage,
    "email" : email,
    "uid" : uid,
  };

  static User fromsnap (DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String , dynamic>;
    return User(name: snapshot['name'], email: snapshot['email'], uid: snapshot['uid'], profileImage: snapshot['profileImage']);
  }
}