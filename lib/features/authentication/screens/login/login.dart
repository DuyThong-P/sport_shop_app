import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../common/styles/spacing_styles.dart';
import '../../../../common/widgets/login_signup/form_divider.dart';
import '../../../../common/widgets/login_signup/social_buttons.dart';
import '../../../../utils/contants/sizes.dart';
import '../../../../utils/contants/text_string.dart';
import 'widgets/login_form.dart';
import 'widgets/login_header.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: MSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            children: [
              const LoginHeader(),
              const LoginForm(),

              /// divider
              MFormDivider(
                dividerText: MTexts.orSignInWith.capitalize!,
              ),
              const SizedBox(height: MSizes.spaceBtwItems),

              /// Footer
              const MSocialButtons()
            ],
          ),
        ),
      ),
    );
  }
}
