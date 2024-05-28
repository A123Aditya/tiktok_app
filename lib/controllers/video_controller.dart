import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tiktok_app/constants.dart';

import '../models/video.dart';

class VideoController extends GetxController {
  final Rx<List<Video>> _videosList = Rx<List<Video>>([]);
  List<Video> get videoList => _videosList.value;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _videosList.bindStream(
        fireStore.collection("videos").snapshots().map((QuerySnapshot query) {
      List<Video> retvalue = [];
      for (var element in query.docs) {
        retvalue.add(Video.fromSnap(element));
      }
      return retvalue;
    }));
  }

  likeVideo(String id) async {
    DocumentSnapshot doc = await fireStore.collection("videos").doc(id).get();
    var uid = authcontroller.user.uid;
    print(uid);
    if ((doc.data()! as dynamic)["likes"].contains(uid)) {
      await fireStore.collection("videos").doc(id).update({
        "likes": FieldValue.arrayRemove([uid])
      });
    } else {
      await fireStore.collection("videos").doc(id).update({
        "likes": FieldValue.arrayUnion([uid])
      });
    }
  }

  // likeVideo(String id) async {
  //   try {
  //     DocumentSnapshot doc = await fireStore.collection("videos").doc(id).get();

  //     var uid = authcontroller.user.uid;

  //     if (doc.exists) {
  //       var data = doc.data()! as Map<String, dynamic>;

  //       // Debug: Print the document data
  //       print("Document data: $data");

  //       // Ensure 'likes' field is present and is a list
  //       List likes = data["likes"] ?? [];

  //       // Debug: Print the likes list
  //       print("Likes list: $likes");

  //       if (likes.contains(uid)) {
  //         await fireStore.collection("videos").doc(id).update({
  //           "likes": FieldValue.arrayRemove([uid])
  //         });
  //       } else {
  //         await fireStore.collection("videos").doc(id).update({
  //           "likes": FieldValue.arrayUnion([uid])
  //         });
  //       }
  //     } else {
  //       // Handle the case where the document does not exist
  //       print("Document does not exist.");
  //     }
  //   } catch (e) {
  //     // Handle any errors
  //     print("Error liking video: $e");
  //   }
  // }
}
