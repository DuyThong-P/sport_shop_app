import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../features/personalization/controllers/user_controller.dart';
import '../../../utils/contants/colors.dart';
import '../../../utils/contants/image_strings.dart';
import '../images/circular_image.dart';

class MUserProfileTile extends StatelessWidget {
  MUserProfileTile({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;
  final controller = UserController.instance;
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isNetworkImage = controller.user.value.profilePicture.isNotEmpty;
      final image =
          isNetworkImage ? controller.user.value.profilePicture : MImages.user;
      return ListTile(
        leading: MCircularImage(
            padding: 0,
            image: image,
            width: 50,
            height: 50,
            isNetworkImage: isNetworkImage),
        title: Text(controller.user.value.fullName,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: MColors.white)),
        subtitle: Text(controller.user.value.email,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: MColors.white)),
        trailing: IconButton(
            onPressed: onPressed,
            icon: const Icon(Iconsax.edit, color: MColors.white)),
      );
    });
  }
}
