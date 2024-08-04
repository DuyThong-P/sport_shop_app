import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../utils/contants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/fullscreen_loader.dart';
import '../../../utils/popups/loader.dart';
import '../../personalization/controllers/user_controller.dart';

class LoginController extends GetxController {
  //* Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final localStorage = GetStorage();
  final userController = Get.put(UserController());
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    email.text = localStorage.read('REMEMBER_ME_EMAIL') ?? '';
    password.text = localStorage.read('REMEMBER_ME_PASSWORD') ?? '';
    super.onInit();
  }

  //* -- Email and Password SignIn
  Future<void> emailAndPasswordSignIn() async {
    try {
      //* Start Loading
      MFullScreenLoader.openLoadingDialog(
          'Đang đăng nhập...', MImages.docerAnimation);

      //* Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MFullScreenLoader.stopLoading();
        return;
      }

      //* Form Validation
      if (!loginFormKey.currentState!.validate()) {
        MFullScreenLoader.stopLoading();
        return;
      }

      //* Save Data if Remember Me is selected
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
      }

      //* Login user using Email & Password Authentication
      final userCredentials = await AuthenticationRepository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //* Assign user data to RxUser of UserController to use in app
      await userController.fetchUserRecord();

      //* Remove Loader
      MFullScreenLoader.stopLoading();

      //* Redirect
      await AuthenticationRepository.instance
          .screenRedirect(userCredentials.user);
    } catch (e) {
      MFullScreenLoader.stopLoading();
      MLoaders.errorSnackBar(title: 'Ôi Không', message: e.toString());
    }
  }

  //* -- Google SignIn Authentication
  Future<void> googleSignIn() async {
    try {
      //* Start Loading
      MFullScreenLoader.openLoadingDialog(
          'Đang đăng nhập...', MImages.docerAnimation);

      //* Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        MFullScreenLoader.stopLoading();
        return;
      }

      //* Google Authentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      // Save Authenticated user data in the Firebase Firestore
      await userController.saveUserRecord(userCredentials: userCredentials);

      //* Remove Loader
      MFullScreenLoader.stopLoading();

      //* Redirect
      await AuthenticationRepository.instance
          .screenRedirect(userCredentials?.user);
    } catch (e) {
      //* Remove Loader
      MFullScreenLoader.stopLoading();
      MLoaders.errorSnackBar(title: 'Ôi Không', message: e.toString());
    }
  }

  /// Facebook SignIn Authentication
  // Future<void> facebookSignIn() async {
  //   try {
  //     // Start Loading
  //     MFullScreenLoader.openLoadingDialog(
  //         'Đang đăng nhập...', MImages.docerAnimation);

  //     // Check Internet Connectivity
  //     final isConnected = await NetworkManager.instance.isConnected();
  //     if (!isConnected) {
  //       MFullScreenLoader.stopLoading();
  //       return;
  //     }

  //     // Facebook Authentication
  //     final userCredentials =
  //         await AuthenticationRepository.instance.signInWithFacebook();

  //     // Save Authenticated user data in the Firebase Firestore
  //     await userController.saveUserRecord(userCredentials: userCredentials);

  //     // Remove Loader
  //     MFullScreenLoader.stopLoading();

  //     // Redirect
  //     await AuthenticationRepository.instance
  //         .screenRedirect(userCredentials.user);
  //   } catch (e) {
  //     MFullScreenLoader.stopLoading();
  //     MLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
  //   }
  // }
}
