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
    _videosList.bindStream(fireStore.collection("videos").snapshots().map((QuerySnapshot query){
      List<Video> retvalue = [];
      for (var element in query.docs) {
        retvalue.add(Video.fromSnap(element));
      }
      return retvalue;
    }));
  }
}