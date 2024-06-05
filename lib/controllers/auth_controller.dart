import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_app/constants.dart';
import 'package:tiktok_app/views/screens/auth/login_screen.dart';
import 'package:tiktok_app/views/screens/home_Screen.dart';
import '../models/users.dart' as model;

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<User?> _user;
  RxBool isloginTapped = false.obs;
  User get user => _user.value!;

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(
      _user,
      _setInitialScreen,
    );
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      Get.offAll(() => HomeScreen());
    }
  }

  // pickImage
  late Rx<File?> _pickedImage;
  File? get profilePic => _pickedImage.value;
  void pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar("Profile Picture", "Profile Image Selected");
    }
    _pickedImage = Rx<File?>(File(pickedImage!.path));
  }

  // upload profileImage
  Future<String> _uploadProfileImage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snapshot = await uploadTask;
    String downloadUrl = await snapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  // registering the user
  Future<void> registerUser(
      String UserName, String email, String Password, File? image) async {
    try {
      if (UserName.isNotEmpty &&
          email.isNotEmpty &&
          Password.isNotEmpty &&
          image != null) {
        // save User to database
        UserCredential cred = await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: Password);
        String downloadUrl = await _uploadProfileImage(image);
        model.User user = model.User(
            name: UserName,
            email: email,
            profileImage: downloadUrl,
            uid: cred.user!.uid);
        await fireStore
            .collection('users')
            .doc(cred.user!.uid)
            .set(user.toJson());
        Get.back();
      }
    } catch (e) {
      Get.snackbar("error in Creating account", e.toString());
    }
  }

  void loginUser(String email, String Password) async {
    try {
      if (email.isNotEmpty && Password.isNotEmpty) {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: Password);
        Get.snackbar("logged", "SucessFully Loged in");
      } else {
        Get.snackbar("Error", "There is Some Error in Login");
      }
    } catch (e) {
      isloginTapped.value = false;
      Get.snackbar("Error", "There is Some Error in Login");
    }
  }

  void logoutUser() async{
    try {
      Get.snackbar("Logging out", "See you later !! ");
      await firebaseAuth.signOut();
    } catch (e) {
      
    }
  }
}
