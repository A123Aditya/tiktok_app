import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class ConfirmScreen extends StatefulWidget {
  const ConfirmScreen({Key? key, required this.videofile});
  final XFile videofile;
  @override
  State<ConfirmScreen> createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.87,
                  width: MediaQuery.of(context).size.width,
                  child: VideoPlayer(_videoPlayerController),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 8.w, right: 8.w, bottom: 8.h, top: 8.h),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(4.r)),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.purple.shade200.withOpacity(0.4),
                      ),
                      child: TextField(
                        controller: _videoCaption,
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          hintText: "Enter Caption for video",
                          hintStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.only(left: 8),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Center(
            //   child: _videoPlayerController.value.isInitialized
            //       ? AspectRatio(
            //           aspectRatio: _videoPlayerController.value.aspectRatio,
            //           child: VideoPlayer(_videoPlayerController),
            //         )
            //       : Container(),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _videoPlayerController.value.isPlaying
                ? _videoPlayerController.pause()
                : _videoPlayerController.play();
          });
        },
        child: Icon(
          _videoPlayerController.value.isPlaying
              ? Icons.pause
              : Icons.play_arrow,
        ),
      ),
    );
  }
}
