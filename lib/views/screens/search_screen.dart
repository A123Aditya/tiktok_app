import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tiktok_app/views/screens/Profile_screen.dart';

import '../../controllers/search_controller.dart';
import '../../models/users.dart';
import 'video_screen.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchUserController searchController = Get.put(SearchUserController());

  final TextEditingController _searchControllerText = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Find friends",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner_sharp, color: Colors.black),
            onPressed: () {
              // Action for QR code scanner
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: TextField(
              style: TextStyle(color: Colors.black),
              cursorColor: Colors.black54,
              controller: _searchControllerText,
              onChanged: (value) {
                searchController.searchUser(value);
              },
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black38,
                ),
                hintText: "Search",
                hintStyle: TextStyle(color: Colors.black38),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.r),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              return ListView.builder(
                itemCount: searchController.searchedUser.length,
                itemBuilder: (context, index) {
                  var user = searchController.searchedUser[index];
                  return _buildUserListItem(user);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildUserListItem(User user) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(user.profileImage),
      ),
      title: Text(
        user.name,
        style: TextStyle(color: Colors.black),
      ),
      subtitle: Text(user.email, style: TextStyle(color: Colors.black45)),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black),
      onTap: () {
        Get.to(ProfileScreen(uid: user.uid));
      },
    );
  }

  Widget _buildListItem({
    required IconData icon,
    required Color color,
    required String text,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Icon(icon, color: Colors.white),
      ),
      title: Text(
        text,
        style: TextStyle(color: Colors.black38),
      ),
      trailing: Icon(Icons.arrow_forward_ios, color: Colors.black38),
      onTap: () {},
    );
  }
}
