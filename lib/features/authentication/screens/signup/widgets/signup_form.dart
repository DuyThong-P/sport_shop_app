import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../utils/contants/sizes.dart';
import '../../../../../utils/contants/text_string.dart';
import '../../../../../utils/validator/validation.dart';
import '../../../controllers/signup_controller.dart';
import 'terms_conditions_checkbox.dart';

class MSignupForm extends StatelessWidget {
  const MSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Form(
        key: controller.signupFormKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: controller.firstName,
                    validator: (value) =>
                        MValidator.validateEmptyText('Tên ', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: MTexts.firstName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                ),
                const SizedBox(width: MSizes.spaceBtwInputFields),
                Expanded(
                  child: TextFormField(
                    controller: controller.lastName,
                    validator: (value) =>
                        MValidator.validateEmptyText('Họ', value),
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: MTexts.lastName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: MSizes.spaceBtwInputFields),

            //* Username
            // TextFormField(
            //   controller: controller.username,
            //   validator: (value) =>
            //       MValidator.validateEmptyText('Tên đăng nhập', value),
            //   expands: false,
            //   decoration: const InputDecoration(
            //       labelText: MTexts.username,
            //       prefixIcon: Icon(Iconsax.user_edit)),
            // ),
            // const SizedBox(height: MSizes.spaceBtwInputFields),

            //* Email
            TextFormField(
              controller: controller.email,
              validator: (value) => MValidator.validateEmail(value),
              decoration: const InputDecoration(
                  labelText: MTexts.email, prefixIcon: Icon(Iconsax.direct)),
            ),
            const SizedBox(height: MSizes.spaceBtwInputFields),

            //* Phone
            TextFormField(
              controller: controller.phoneNumber,
              validator: (value) => MValidator.validatePhoneNumber(value),
              decoration: const InputDecoration(
                  labelText: MTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
            ),
            const SizedBox(height: MSizes.spaceBtwInputFields),

            //* Password
            Obx(
              () => TextFormField(
                controller: controller.password,
                validator: (value) => MValidator.validatePassword(value),
                obscureText: controller.hidePasswork.value,
                decoration: InputDecoration(
                  labelText: MTexts.password,
                  prefixIcon: const Icon(Iconsax.password_check),
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePasswork.value =
                        !controller.hidePasswork.value,
                    icon: Icon(controller.hidePasswork.value
                        ? Iconsax.eye_slash
                        : Iconsax.eye),
                  ),
                ),
              ),
            ),
            const SizedBox(height: MSizes.spaceBtwInputFields),

            //* Terms&Conditions Checkbox
            const MTermsAndConditionsCheckbox(),
            const SizedBox(height: MSizes.spaceBtwSections),

            //* Sign Up Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.signup(),
                child: const Text(MTexts.createAccount),
              ),
            )
          ],
        ));
  }
}
