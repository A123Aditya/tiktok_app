import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_app/views/screens/confirm_screen.dart';

class AddVideoScreen extends StatelessWidget {
  AddVideoScreen({super.key});
  late XFile videofile;
  pickVideo(ImageSource src, BuildContext context) async {
    final video = await ImagePicker().pickVideo(source: src);
    if (video != null) {
      videofile = video;
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConfirmScreen(
              videofile: videofile,
            ),
          ));
    }
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            SimpleDialogOption(
              onPressed: () {
                pickVideo(ImageSource.gallery, context);
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/Icons/gallery.png")),
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 13.w),
                    child: Text("From Gallery"),
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                pickVideo(ImageSource.camera, context);
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/Icons/camera.png")),
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 13.w),
                    child: Text("From Camera"),
                  )
                ],
              ),
            ),
            SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.r),
                    child: Container(
                      height: 40.h,
                      width: 40.w,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/Icons/cancel.png")),
                          color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 13.w),
                    child: Text("Cancel"),
                  )
                ],
              ),
            )
          ],
          // child: Row(
          //   children: [
          //     Container(
          //       decoration: BoxDecoration(
          //           image: DecorationImage(
          //               image: AssetImage("assets/Icons/gallery.png"))),
          //     ),
          //     Text("From Gallery")
          //   ],
          // ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Text("Post a video"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        onPressed: () {
          showOptionsDialog(context);
        },
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/Icons/add.png"),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
