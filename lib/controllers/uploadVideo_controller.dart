import 'package:get/get.dart';
import 'package:video_compress/video_compress.dart';

class UploadvideoController extends GetxController{

  // compress Video
  _compressVideo (String videoPath)async{
    final compressedVideo = await VideoCompress.compressVideo(videoPath,quality: VideoQuality.HighestQuality);
    return compressedVideo!.file;
  }

  uploadVideo(String videoCaption, String videoPath) async{
    try {
      
    } catch (e) {
      
    }
  }
}