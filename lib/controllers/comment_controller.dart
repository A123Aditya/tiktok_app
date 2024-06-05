import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:tiktok_app/constants.dart';
import 'package:tiktok_app/models/comments.dart';

class CommentController extends GetxController {
  final Rx<List<Comments>> _comments = Rx<List<Comments>>([]);
  List<Comments> get comments => _comments.value;
  String _postId = "";

  updatePostId(String id) {
    _postId = id;
    getComments();
  }

  getComments() async {
    _comments.bindStream(fireStore
        .collection("videos")
        .doc(_postId)
        .collection("comments")
        .snapshots()
        .map((QuerySnapshot query) {
      List<Comments> retvalue = [];
      for (var element in query.docs) {
        retvalue.add(Comments.fromSnap(element));
      }
      return retvalue;
    }));
  }

  postComment(String commentText) async {
    try {
      if (commentText.isNotEmpty) {
        print("get into the fucntion");
        DocumentSnapshot userdocs = await fireStore
            .collection("users")
            .doc(authcontroller.user.uid)
            .get();
        // creating a comments section inside each video collection , _postId = videoid
        var allDocs = await fireStore
            .collection("videos")
            .doc(_postId)
            .collection("comments")
            .get();
        int len = allDocs.docs.length;
        Comments comments = Comments(
            username: (userdocs.data()! as dynamic)['name'],
            comment: commentText,
            datepublished: DateTime.now(),
            likes: [],
            profilePhoto: (userdocs.data() as dynamic)['profileImage'],
            uid: authcontroller.user.uid,
            id: 'Comment $len');
        await fireStore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('Comment $len')
            .set(comments.toJson());
        DocumentSnapshot doc =
            await fireStore.collection("videos").doc(_postId).get();
        fireStore.collection("videos").doc(_postId).update({
          "commentCount": (doc.data() as dynamic)["commentCount"] + 1,
        });
      }
      Get.snackbar("Commets added", "Comments Sucessfully posted");
    } catch (e) {
      Get.snackbar("SomeThing Went Wrong", e.toString());
    }
  }

  likeComment(String id) async {
    var uid = authcontroller.user.uid;
    DocumentSnapshot doc = await fireStore
        .collection("videos")
        .doc(_postId)
        .collection("comments")
        .doc(id)
        .get();
    print("this is data ${doc.data()}");
    if ((doc.data() as dynamic)["likes"].contains(uid)) {
      await fireStore
          .collection("videos")
          .doc(_postId)
          .collection("comments")
          .doc(id)
          .update({
        "likes": FieldValue.arrayRemove([uid]),
      });
    } else {
      await fireStore
          .collection("videos")
          .doc(_postId)
          .collection("comments")
          .doc(id)
          .update({
        "likes": FieldValue.arrayUnion([uid]),
      });
    }
  }
}
