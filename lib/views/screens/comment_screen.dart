import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok_app/constants.dart';
import 'package:tiktok_app/controllers/comment_controller.dart';
import 'package:timeago/timeago.dart' as tago;

class CommentSection extends StatefulWidget {
  final String id;
  final String profilePics;
  final String userName;

  CommentSection({
    required this.id,
    required this.profilePics,
    required this.userName,
  });

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final CommentController commentController = Get.put(CommentController());
  final TextEditingController comment = TextEditingController();

  @override
  void initState() {
    super.initState();
    commentController.updatePostId(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return SingleChildScrollView(
          controller: scrollController,
          child: Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.vertical(top: Radius.circular(16.0)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 4,
                  width: 40,
                  decoration: BoxDecoration(
                    color: Colors.black26,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                SizedBox(height: 16),
                Flexible(
                  fit: FlexFit.loose,
                  child: Obx(
                    () => ListView.builder(
                      controller: scrollController,
                      shrinkWrap: true,
                      itemCount: commentController.comments.length,
                      itemBuilder: (context, index) {
                        final comment = commentController.comments[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(comment.profilePhoto),
                          ),
                          title: Text(
                            comment.username,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.comment,
                                style: TextStyle(color: Colors.white),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                      tago.format(
                                          comment.datepublished.toDate()),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.sp)),
                                  SizedBox(
                                    width: 50.w,
                                  ),
                                  InkWell(
                                    onTap: () => commentController
                                        .likeComment(comment.id),
                                    child: comment.likes
                                            .contains(authcontroller.user.uid)
                                        ? Container(
                                            width: 15.w,
                                            height: 15.h,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/Icons/heart.png"))),
                                          )
                                        : Container(
                                            width: 15.w,
                                            height: 15.h,
                                            decoration: const BoxDecoration(
                                                image: DecorationImage(
                                                    image: AssetImage(
                                                        "assets/Icons/love.png"))),
                                          ),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  Text(comment.likes.length.toString())
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: TextField(
                    controller: comment,
                    decoration: InputDecoration(
                      labelText: 'Add a comment...',
                      suffixIcon: IconButton(
                        icon: Icon(Icons.send),
                        onPressed: () {
                          commentController
                              .postComment(comment.text.toString());
                          comment.clear();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
