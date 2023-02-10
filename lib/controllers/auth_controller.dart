import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tiktok_clone/constants.dart';
import 'package:tiktok_clone/models/user.dart' as model;
import 'package:tiktok_clone/views/screens/auth/login_screen.dart';
import 'package:tiktok_clone/views/screens/home_screen.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();
  late Rx<File?> _pickedImage;
  late Rx<User?> _user;
  File? get profilePhoto => _pickedImage.value;
  User get user => _user.value!;
  RxBool isLoading = false.obs;

  @override
  onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    _user.bindStream(firebaseAuth.authStateChanges());
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
    isLoading.value = false;
    if (user == null) {
      Get.offAll(
        () => LoginScreen(),
      );
    } else {
      Get.offAll(
        () => const HomeScreen(),
      );
    }
  }

  //Pick Image
  Future<void> pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Get.snackbar(
        'Profile Pic',
        'Profile Pic Selected Successfully',
      );
      _pickedImage = Rx<File?>(
        File(pickedImage.path),
      );
    } else {
      Get.snackbar(
        'Profile Pic',
        'No Profile Pic Selected',
      );
    }
  }

  //upload image to firebase storage
  Future<String> _uploadToStorage(File image) async {
    Reference ref = firebaseStorage
        .ref()
        .child('profilePics')
        .child(firebaseAuth.currentUser!.uid);
    UploadTask uploadTask = ref.putFile(image);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }

  //registering the user
  void register(
    String username,
    String password,
    String email,
    File? image,
  ) async {
    try {
      isLoading.value = true;
      // Save our user to auth & firestore
      UserCredential userCredential =
          await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      String downloadUrl = await _uploadToStorage(image!);
      model.User user = model.User(
        username: username,
        profilePhoto: downloadUrl,
        email: email,
        uid: firebaseAuth.currentUser!.uid,
      );
      firebaseFirestore.collection('users').doc(userCredential.user!.uid).set(
            user.toJson(),
          );
    } catch (e) {
      Get.snackbar(
        'Error Creating Account',
        e.toString(),
      );
    }
    isLoading.value = false;
  }

  //Login User

  void loginUser(String email, String password) async {
    isLoading.value = true;
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      isLoading.value = false;
      Get.snackbar(
        'Error Logging In',
        e.toString(),
      );
    }
  }

  void signOut() async {
    await firebaseAuth.signOut();
  }
}
