import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok_app/constants.dart';
import 'package:tiktok_app/controllers/profile_controller.dart';

class ProfileScreen extends StatefulWidget {
  String uid;
  ProfileScreen({
    super.key,
    required this.uid,
  });

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ProfileController profileController = Get.put(ProfileController());
  @override
  void initState() {
    profileController.updateUserID(widget.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
      ),
      backgroundColor: Colors.white,
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (controller) {
          if (controller.user.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 20.h),
                ClipOval(
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: controller.user['profileImage'],
                    height: 100.h,
                    width: 100.h,
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(
                      Icons.error,
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  controller.user['name'] ?? 'Loading...',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildStatItem(
                        controller.user['following'] ?? '0', 'Following'),
                    SizedBox(width: 16.w),
                    _buildStatItem(
                        controller.user['followers'] ?? '0', 'Followers'),
                    SizedBox(width: 16.w),
                    _buildStatItem(controller.user['likes'] ?? '0', 'Likes'),
                  ],
                ),
                SizedBox(height: 20.h),
                ElevatedButton(
                    onPressed: () {
                      if (widget.uid == authcontroller.user.uid) {
                        authcontroller.logoutUser();
                      } else {
                        controller.followUser();
                      }
                    },
                    child: Text(
                      widget.uid == authcontroller.user.uid
                          ? "Sign Out"
                          : (controller.user['isFollowing']
                              ? "UnFollow"
                              : "Follow"),
                    )),
                SizedBox(height: 10.h),
                SizedBox(height: 20.h),
                Divider(
                  color: Colors.grey[300],
                  thickness: 1,
                ),
                _buildGrid(controller.user['thumbNail'] ?? []),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatItem(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: TextStyle(
            color: Colors.black54,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildGrid(List thumbnailList) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 4.w,
        mainAxisSpacing: 4.h,
      ),
      itemCount: thumbnailList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(left: 8.w, right: 8.w),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(
                image: NetworkImage(thumbnailList[index]),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}
