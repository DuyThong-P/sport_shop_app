import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/images/circular_image.dart';
import '../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/contants/image_strings.dart';
import '../../../../utils/contants/sizes.dart';
import '../../controllers/user_controller.dart';
import 'change_name.dart';
import 'widgets/profile_menu.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: MAppBar(
        showBackArrow: true,
        title: Text('Hồ sơ', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(MSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(() {
                      final isNetworkImage =
                          controller.user.value.profilePicture.isNotEmpty;
                      final image = isNetworkImage
                          ? controller.user.value.profilePicture
                          : MImages.user;
                      const loader =
                          MShimmerEffect(width: 80, height: 80, radius: 80);
                      return controller.imageUploading.value
                          ? loader
                          : MCircularImage(
                              image: image,
                              width: 80,
                              height: 80,
                              isNetworkImage: isNetworkImage);
                    }),
                    TextButton(
                        onPressed: controller.imageUploading.value
                            ? () {}
                            : () => controller.uploadUserProfilePicture(),
                        child: const Text('Thay đổi ảnh đại diện')),
                  ],
                ),
              ),
              const SizedBox(height: MSizes.spaceBtwItems / 2),
              const Divider(),
              const SizedBox(height: MSizes.spaceBtwItems),
              const MSectionHeading(
                  title: 'Thông tin hồ sơ', showActionButton: false),
              const SizedBox(height: MSizes.spaceBtwItems),
              MProfileMenu(
                  onPressed: () => Get.to(() => const ChangeName()),
                  title: 'Tên',
                  value: controller.user.value.fullName),
              MProfileMenu(
                  onPressed: () {},
                  title: 'Người dùng',
                  value: controller.user.value.username),
              const SizedBox(height: MSizes.spaceBtwItems),
              const Divider(),
              const SizedBox(height: MSizes.spaceBtwItems),
              const MSectionHeading(
                  title: 'Thông tin cá nhân', showActionButton: false),
              const SizedBox(height: MSizes.spaceBtwItems),
              MProfileMenu(
                  onPressed: () {},
                  title: 'ID',
                  value: '45689',
                  icon: Iconsax.copy),
              MProfileMenu(
                  onPressed: () {},
                  title: 'Email',
                  value: controller.user.value.email),
              MProfileMenu(
                  onPressed: () {},
                  title: 'Số điện thoại',
                  value: controller.user.value.phoneNumber),
              MProfileMenu(onPressed: () {}, title: 'Giới tính', value: 'Nam'),
              MProfileMenu(
                  onPressed: () {},
                  title: 'Ngày sinh',
                  value: '1 tháng 1, 1900'),
              const Divider(),
              const SizedBox(height: MSizes.spaceBtwItems),
              Center(
                child: TextButton(
                    onPressed: () => controller.deleteAccountWarningPopup(),
                    child: const Text('Đóng tài khoản',
                        style: TextStyle(color: Colors.red))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
