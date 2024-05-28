import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tiktok_app/controllers/comment_controller.dart';

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
                            backgroundImage: NetworkImage(widget.profilePics),
                          ),
                          title: Text(
                            widget.userName,
                            style: TextStyle(color: Colors.white),
                          ),
                          subtitle: Text(
                            comment.toString(),
                            style: TextStyle(color: Colors.white),
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
