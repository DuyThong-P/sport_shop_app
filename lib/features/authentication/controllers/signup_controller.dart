import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/repositories/authentication/authentication_repository.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../utils/contants/image_strings.dart';
import '../../../utils/helpers/network_manager.dart';
import '../../../utils/popups/fullscreen_loader.dart';
import '../../../utils/popups/loader.dart';
import '../../personalization/models/user_model.dart';
import '../screens/signup/verify_email.dart';

class SignupController extends GetxController {
  static SignupController get instance => Get.find();

  //* Variables
  final hidePasswork = true.obs; //* Observable for hiding/showing passwork
  final privacyPolicy = true.obs; //* Observable for privacy policy acceptance
  final email = TextEditingController(); // Controller for email input
  final lastName = TextEditingController(); // Controller for lastName input
  final username = TextEditingController(); // Controller for username input
  final password = TextEditingController(); // Controller for password input
  final firstName = TextEditingController(); // Controller for firstName input
  final phoneNumber =
      TextEditingController(); // Controller for phoneNumber input
  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  //* -- Signup
  Future<void> signup() async {
    try {
      //* Start Loading
      MFullScreenLoader.openLoadingDialog(
          'Chúng tôi đang xử lý thông tin của bạn...', MImages.docerAnimation);

      //* Check Internet Connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        //* Remove Loader
        MFullScreenLoader.stopLoading();
        return;
      }

      //* Form Validation
      if (!signupFormKey.currentState!.validate()) {
        //* Remove Loader
        MFullScreenLoader.stopLoading();
        return;
      }

      //* Privacy Policy Check
      if (!privacyPolicy.value) {
        MLoaders.warningSnackBar(
            title: 'Chú ý!',
            message:
                'Để tạo tài khoản, bạn phải đọc và chấp nhận Quyền riêng tư & Điều khoản sử dụng.');
        return;
      }

      //* Register user in the Firebase Authentication & Save user data in the Firebase
      final userCredential = await AuthenticationRepository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      //* Save Authenticated user data in the Firebase Firestore
      final newUser = UserModel(
        id: userCredential.user!.uid,
        firstName: firstName.text.trim(),
        lastName: lastName.text.trim(),
        username: username.text.trim(),
        email: email.text.trim(),
        phoneNumber: phoneNumber.text.trim(),
        profilePicture: '',
      );

      final userRepository = Get.put(UserRepository());
      await userRepository.saveUserRecord(newUser);

      //* Remove Loader
      MFullScreenLoader.stopLoading();

      //* Show success Message
      MLoaders.successSnackBar(
          title: 'Chúc mừng',
          message:
              'Tài khoản của bạn đã được tạo! Xác nhận email để tiếp tục.');

      //* Move to Verify Email Screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
    } catch (e) {
      //* Remove Loader
      MFullScreenLoader.stopLoading();

      //* Show some Generic Error to the user
      MLoaders.errorSnackBar(title: 'Ôi Không!', message: e.toString());
    }
  }
}
