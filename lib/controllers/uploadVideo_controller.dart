import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:tiktok_app/constants.dart';
import 'package:tiktok_app/models/video.dart';
import 'package:video_compress/video_compress.dart';

class UploadvideoController extends GetxController {
  static UploadvideoController instance = Get.find();
  RxDouble value = 0.0.obs;
  RxBool isUploadTaskStarted = false.obs;
  // compress Video
  Future<File?> _compressVideo(String videoPath) async {
    Get.snackbar("Video Compressing", "Video is Compressing please wait!!");
    final compressedVideo = await VideoCompress.compressVideo(
      videoPath,
      quality: VideoQuality.MediumQuality,
    );
    if (compressedVideo != null) {
      return compressedVideo.file;
    }
    return null;
  }

  // ThumbNail for video
  Future<File> _getThumbNail(String videoPath) async {
    final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
    return thumbnail;
  }

  // Upload Video to Storage
  Future<String> _uploadVideoToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child("videos").child(id);
    File? compressedVideo = await _compressVideo(videoPath);
    UploadTask uploadTask = ref.putFile(compressedVideo!);
    isUploadTaskStarted.value = true;
    uploadTask.snapshotEvents.listen(
      (event) {
        double progress =
            (event.bytesTransferred.toDouble() / event.totalBytes.toDouble()) *
                100;
        value.value = progress / 100;
        print("this is value going on $value");
      },
    );

    TaskSnapshot snapshot = await uploadTask;
    isUploadTaskStarted.value = false;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // percent of files transferred

  bytesTransferred(double value) {}

  // Upload Image to Storage
  Future<String> _uploadImageToStorage(String id, String videoPath) async {
    Reference ref = firebaseStorage.ref().child("thumbnail").child(id);
    File thumbnailFile = await _getThumbNail(videoPath);
    UploadTask uploadTask = ref.putFile(thumbnailFile);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  uploadVideo(String videoCaption, String videoPath) async {
    try {
      // current user uid
      String uid = firebaseAuth.currentUser!.uid;

      // getting all info of User Stored in FireStore like Email,ProfilePic,Name
      DocumentSnapshot userDoc =
          await fireStore.collection('users').doc(uid).get();
      var allDocs = await fireStore.collection('videos').get();
      int len = allDocs.docs.length;
      String videoUrl = await _uploadVideoToStorage("video $len", videoPath);
      String thumbnail = await _uploadImageToStorage("video $len", videoPath);
      Video video = Video(
          userName: (userDoc.data()! as Map<String, dynamic>)['name'],
          uid: uid,
          id: "video $len",
          likes: [],
          commentCount: 0,
          shareCount: 0,
          caption: videoCaption,
          videoUrl: videoUrl,
          thumbNail: thumbnail,
          profilePhoto:
              (userDoc.data()! as Map<String, dynamic>)['profileImage']);
      await fireStore
          .collection('videos')
          .doc('video $len')
          .set(video.toJson());
      Get.back();
    } catch (e) {
      print(e.toString());
      Get.snackbar("Error Uploading Video", e.toString(),
          duration: Duration(seconds: 4));
    }
  }
}

// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:get/get.dart';
// import 'package:tiktok_app/constants.dart';
// import 'package:tiktok_app/models/video.dart';
// import 'package:video_compress/video_compress.dart';

// class UploadvideoController extends GetxController {
//   static UploadvideoController instance = Get.find();

//   // Compress Video
//   Future<File?> _compressVideo(String videoPath) async {
//     final compressedVideo = await VideoCompress.compressVideo(
//       videoPath,
//       quality: VideoQuality.MediumQuality,
//     );
//     return compressedVideo?.file;
//   }

//   // Thumbnail for video
//   Future<File?> _getThumbnail(String videoPath) async {
//     final thumbnail = await VideoCompress.getFileThumbnail(videoPath);
//     return thumbnail;
//   }

//   // Upload Video to Storage
//   Future<String?> _uploadVideoToStorage(String id, String videoPath) async {
//     Reference ref = firebaseStorage.ref().child("videos").child(id);
//     File? compressedVideo = await _compressVideo(videoPath);
//     if (compressedVideo == null) {
//       throw Exception("Video compression failed");
//     }
//     UploadTask uploadTask = ref.putFile(compressedVideo);
//     TaskSnapshot snapshot = await uploadTask;
//     return await snapshot.ref.getDownloadURL();
//   }

//   // Upload Image to Storage
//   Future<String?> _uploadImageToStorage(String id, String videoPath) async {
//     Reference ref = firebaseStorage.ref().child("thumbnail").child(id);
//     File? thumbnailFile = await _getThumbnail(videoPath);
//     if (thumbnailFile == null) {
//       throw Exception("Thumbnail generation failed");
//     }
//     UploadTask uploadTask = ref.putFile(thumbnailFile);
//     TaskSnapshot snapshot = await uploadTask;
//     return await snapshot.ref.getDownloadURL();
//   }

//   Future<void> uploadVideo(String videoCaption, String videoPath) async {
//     try {
//       // Current user uid
//       String? uid = firebaseAuth.currentUser?.uid;
//       if (uid == null) {
//         throw Exception("User is not logged in");
//       }

//       // Getting all info of User Stored in Firestore like Email, ProfilePic, Name
//       DocumentSnapshot userDoc =
//           await fireStore.collection('users').doc(uid).get();
//       if (!userDoc.exists) {
//         throw Exception("User document does not exist");
//       }

//       Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
//       if (userData == null) {
//         throw Exception("User data is null");
//       }

//       var allDocs = await fireStore.collection('videos').get();
//       int len = allDocs.docs.length;

//       String? videoUrl = await _uploadVideoToStorage("Video $len", videoPath);
//       if (videoUrl == null) {
//         throw Exception("Failed to upload video to storage");
//       }

//       String? thumbnail = await _uploadImageToStorage("Video $len", videoPath);
//       if (thumbnail == null) {
//         throw Exception("Failed to upload thumbnail to storage");
//       }

//       Video video = Video(
//         userName: userData['name'],
//         uid: uid,
//         id: "video $len",
//         likes: [],
//         commentCount: 0,
//         shareCount: 0,
//         caption: videoCaption,
//         videoUrl: videoUrl,
//         thumbNail: thumbnail,
//         profilePhoto: userData['profileImage'],
//       );

//       await fireStore
//           .collection('videos')
//           .doc('Video $len')
//           .set(video.toJson());
//       Get.back();
//     } catch (e) {
//       print(e.toString());
//       Get.snackbar("Error Uploading Video", e.toString(),
//           duration: Duration(seconds: 4));
//     }
//   }
// }
