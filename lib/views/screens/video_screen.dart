// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok_app/controllers/video_controller.dart';
import 'package:tiktok_app/views/screens/comment_screen.dart';
import 'package:tiktok_app/views/widgets/video_player_item.dart';

import '../../constants.dart';
import '../widgets/circle_animation.dart';

class VideoScreen extends StatefulWidget {
  VideoScreen({super.key});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final VideoController videoController = Get.put(VideoController());

  buildProfile(String ImageUrl) {
    return Container(
      height: 58.5.h,
      width: 47.w,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
              image: NetworkImage(ImageUrl), fit: BoxFit.cover)),
    );
  }

  // void showComments(String videoId) {
  //   showModalBottomSheet(
  //     context: context,
  //     isScrollControlled: true,
  //     builder: (context) => CommentSection(id: videoController.videoList.toString(),),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(() => PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: videoController.videoList.length,
          controller: PageController(
            initialPage: 0,
          ),
          itemBuilder: (context, index) {
            final data = videoController.videoList[index];
            void showComments(String videoId) {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => CommentSection(
                  id: data.id,
                  profilePics: data.profilePhoto,
                  userName: data.userName,
                ),
              );
            }

            return Stack(
              children: [
                VideoPlayerItem(videoUrl: data.videoUrl),
                Padding(
                  padding: EdgeInsets.only(top: 703.h, left: 12.w, bottom: 8.h),
                  child: SizedBox(
                    width: 92.w,
                    child: Text(
                      data.userName,
                      style: TextStyle(
                        color: primarytextColor,
                        fontStyle: FontStyle.italic,
                        fontSize: 17.sp,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: 732.h,
                    left: 12.w,
                  ),
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: 332.w,
                      child: Text(
                        data.caption,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 340.w),
                  child: Container(
                    width: 47.w,
                    margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 5,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        buildProfile(data.profilePhoto),
                        Container(
                          width: 100.w,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () =>
                                      videoController.likeVideo(data.id),
                                  child: data.likes
                                          .contains(authcontroller.user.uid)
                                      ? Container(
                                          height: 54.h,
                                          width: 41.w,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/Icons/heart.png"))),
                                        )
                                      : Container(
                                          height: 54.h,
                                          width: 41.w,
                                          decoration: const BoxDecoration(
                                              image: DecorationImage(
                                                  image: AssetImage(
                                                      "assets/Icons/love.png"))),
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: 20,
                                  ),
                                  child: Container(
                                    width: 41.w,
                                    child: Text(
                                      data.likes.length.toString(),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () => showComments(data.id),
                          child: Container(
                            height: 54.h,
                            width: 41.w,
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        "assets/Icons/speech-bubble.png"))),
                          ),
                        ),
                        Container(
                          height: 54.h,
                          width: 41.w,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage("assets/Icons/share.png"))),
                        ),
                        CircleAnimation(
                            child: buildMusicAlbum("assets/Icons/cd.png"))
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}

buildMusicAlbum(String s) {
  return Container(
    height: 49.h,
    width: 49.w,
    decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(s)),
        gradient: const LinearGradient(colors: [Colors.white, Colors.yellow]),
        shape: BoxShape.circle),
  );
}
