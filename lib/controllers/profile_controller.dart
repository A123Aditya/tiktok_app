import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tiktok_app/constants.dart';

class ProfileController extends GetxController {
  final Rx<Map<String, dynamic>> _user = Rx<Map<String, dynamic>>({});
  Map<String, dynamic> get user => _user.value;

  RxString _uid = "".obs;
  updateUserID(String uid) {
    _uid.value = uid;
    getUserData();
  }

  getUserData() async {
    List thumbNail = [];
    var myVideos = await fireStore
        .collection("videos")
        .where("uid", isEqualTo: _uid.value)
        .get();

    for (var i = 0; i < myVideos.docs.length; i++) {
      thumbNail.add((myVideos.docs[i].data() as dynamic)['thumbNail']);
    }

    DocumentSnapshot userDoc =
        await fireStore.collection("users").doc(_uid.value).get();
    final userData = userDoc.data() as dynamic;
    String name = userData['name'];
    String profileImage = userData['profileImage'];
    int likes = 0;
    int followers = 0;
    int following = 0;
    bool isFollowing = false;

    for (var element in myVideos.docs) {
      likes += (element.data()['likes'] as List).length;
    }

    var followersDoc = await fireStore
        .collection("users")
        .doc(_uid.value)
        .collection("followers")
        .get();

    var followingDoc = await fireStore
        .collection("users")
        .doc(_uid.value)
        .collection("following")
        .get();

    followers = followersDoc.docs.length;
    following = followingDoc.docs.length;

    fireStore
        .collection("users")
        .doc(_uid.value)
        .collection("followers")
        .doc(authcontroller.user.uid)
        .get()
        .then(
      (value) {
        if (value.exists) {
          isFollowing = true;
        } else {
          isFollowing = false;
        }
      },
    );

    _user.value = {
      "followers": followers.toString(),
      "following": following.toString(),
      "isFollowing": isFollowing,
      "likes": likes.toString(),
      "profileImage": profileImage,
      "name": name,
      "thumbNail": thumbNail
    };
    update();
  }


  followUser() async{
    var doc = await fireStore.collection("users").doc(_uid.value).collection("followers").doc(authcontroller.user.uid).get();

    if(!doc.exists){
      await fireStore.collection("users").doc(_uid.value).collection("followers").doc(authcontroller.user.uid).set({});
      await fireStore.collection("users").doc(authcontroller.user.uid).collection("following").doc(_uid.value).set({});
      _user.value.update('followers', (value) => (int.parse(value)+1).toString(),);
    }
    else{
      await fireStore
          .collection("users")
          .doc(_uid.value)
          .collection("followers")
          .doc(authcontroller.user.uid)
          .delete();
      await fireStore
          .collection("users")
          .doc(authcontroller.user.uid)
          .collection("following")
          .doc(_uid.value)
          .delete();
      _user.value.update(
        'followers',
        (value) => (int.parse(value) - 1).toString(),
      );
    }
    _user.value.update("isFollowing", (value) => !value,);
    update();
  }
}

