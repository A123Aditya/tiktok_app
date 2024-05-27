import 'package:cloud_firestore/cloud_firestore.dart';

class Video {
  String userName;
  String uid;
  String id;
  List likes;
  int commentCount;
  int shareCount;
  String caption;
  String videoUrl;
  String thumbNail;
  String profilePhoto;
  Video({required this.userName, 
       required this.uid, 
      required this.id,
      required this.likes,
      required this.commentCount,
      required this.shareCount,
      required this.caption,
      required this.videoUrl,
      required this.thumbNail,
      required this.profilePhoto});
  Map<String,dynamic> toJson() =>{
    "userName" : userName,
    "uid" : uid,
    "id" : id,
    "likes" : likes,
    "commentCount" : commentCount,
    "shareCount" : shareCount,
    "caption" : caption,
    "videoUrl" : videoUrl,
    "thumbNail" : thumbNail,
    "profilePhoto" : profilePhoto
  };

  static Video fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String , dynamic>;
    return Video(userName: snapshot["userName"], uid: snapshot["uid"], id: snapshot["id"], likes: snapshot["likes"], commentCount: snapshot["commentCount"], shareCount: snapshot["shareCount"], caption: snapshot['caption'], videoUrl: snapshot["videoUrl"], thumbNail: snapshot["thumbNail"], profilePhoto: snapshot["profilePhoto"]);
  }
}