import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:tiktok_app/constants.dart';
import 'package:tiktok_app/models/comments.dart';

class CommentController extends GetxController{
  final Rx<List<Comments>> _comments = Rx<List<Comments>>([]);
  List<Comments> get comments => _comments.value;
  String _postId = "";
  
  updatePostId(String id){
    _postId = id;
    getComments();
  }
  
  void getComments() {}

  postComment(String commentText) async{
    try {
      if (commentText.isNotEmpty) {
        DocumentSnapshot userdocs = await fireStore
            .collection("users")
            .doc(authcontroller.user.uid)
            .get();
        var allDocs = await fireStore
            .collection("videos")
            .doc(_postId)
            .collection("comments")
            .get();
        int len = allDocs.docs.length;
        Comments comments = Comments(
            username: (userdocs.data()! as dynamic)['username'],
            comment: commentText,
            datepublished: DateTime.now(),
            likes: [],
            profilePhoto: (userdocs.data() as dynamic)['profilePhoto'],
            uid: authcontroller.user.uid,
            id: 'Comment $len');
        await fireStore
            .collection('videos')
            .doc(_postId)
            .collection('comments')
            .doc('Commet $len')
            .set(comments.toJson());
      }
      Get.snackbar("Commets added", "Comments Sucessfully posted");
    } catch (e) {
      Get.snackbar("SomeThing Went Wrong", e.toString());
    }
  }
}

