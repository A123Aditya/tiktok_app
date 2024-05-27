import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:video_player/video_player.dart';

import 'package:tiktok_app/controllers/uploadVideo_controller.dart';

import '../../constants.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({Key? key, required this.videofile});
  final XFile videofile;

  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  UploadvideoController videocontroller = Get.put(UploadvideoController());
  late VideoPlayerController _videoPlayerController;
  TextEditingController _videoCaption = TextEditingController();

  @override
  void initState() {
    super.initState();
    _videoPlayerController =
        VideoPlayerController.file(File(widget.videofile.path))
          ..initialize().then((_) {
            setState(() {
              _videoPlayerController.setLooping(true);
            });
          });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade100.withOpacity(0.1),
      body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Center(
                child: _videoPlayerController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child:
                            Center(child: VideoPlayer(_videoPlayerController)),
                      )
                    : Container(),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.86,
                top: MediaQuery.of(context).size.height * 0.1,
                child: GestureDetector(
                  onTap: () => showOptionsDialog(context),
                  child: Container(
                    height: IconsSize.h,
                    width: IconsSize.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Icons/edit.png"),
                            fit: BoxFit.cover)),
                  ),
                ),
              ),
              Positioned(
                left: MediaQuery.of(context).size.width * 0.86,
                top: MediaQuery.of(context).size.height * 0.195,
                child: Container(
                  height: IconsSize.h,
                  width: IconsSize.w,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/Icons/music.png"),
                          fit: BoxFit.cover)),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.93,
                left: MediaQuery.of(context).size.width * 0.43,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _videoPlayerController.value.isPlaying
                          ? _videoPlayerController.pause()
                          : _videoPlayerController.play();
                    });
                    print("This is ${widget.videofile.path}");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    height: IconsSize.h,
                    width: IconsSize.w,
                    child: _videoPlayerController.value.isPlaying
                        ? Image.asset(
                            "assets/Icons/pause.png",
                            // fit: BoxFit.cover,
                          )
                        : Image.asset(
                            "assets/Icons/play.png",
                            // fit: BoxFit.cover,
                          ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.93,
                left: MediaQuery.of(context).size.width * 0.8,
                child: GestureDetector(
                  onTap: () {
                    videocontroller.uploadVideo(
                        _videoCaption.text.toString(), widget.videofile.path);
                    print("This is ${widget.videofile.path}");
                  },
                  child: Container(
                    height: IconsSize.h,
                    width: IconsSize.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Icons/photo.png"))),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * 0.93,
                left: MediaQuery.of(context).size.width * 0.1,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: IconsSize.h,
                    width: IconsSize.w,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/Icons/trash.png"))),
                  ),
                ),
              ),
              Obx(
                () {
                  if (videocontroller.isUploadTaskStarted.value) {
                    return Align(
                      alignment: Alignment.center,
                      child: Center(
                        child: CircularPercentIndicator(
                          radius: 40.r,
                          lineWidth: 8.w,
                          percent: videocontroller.value.value,
                          center: Text(
                              "${(videocontroller.value.value * 100).toStringAsFixed(0)}%"),
                          progressColor: Colors.green,
                        ),
                      ),
                    );
                  } else {
                    return SizedBox.shrink();
                  }
                },
              ),
            ],
          )),
    );
  }

  showOptionsDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          alignment: Alignment.center,
          backgroundColor: Colors.white,
          children: [
            TextField(
              style: TextStyle(color: Colors.black),
              controller: _videoCaption,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                  hintText: "Enter Caption for video",
                  hintStyle: TextStyle(color: Colors.black),
                  contentPadding: EdgeInsets.only(left: 8),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                  )),
            ),
          ],
        );
      },
    );
  }
}
