import 'package:sport_shop_app/navigation_menu.dart';

import '../../../../common/widgets/list_tiles/user_profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/primary_header_container.dart';
import '../../../../common/widgets/list_tiles/settings_menu_tile.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/contants/colors.dart';
import '../../../../utils/contants/sizes.dart';
import '../../../shop/screens/cart/cart.dart';
import '../../../shop/screens/order/order.dart';
import '../../controllers/user_controller.dart';
import '../address/address.dart';
import '../profile/profile.dart';
import 'upload_data.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return PopScope(
      canPop: false,
      // Intercept the back button press and redirect to Home Screen
      onPopInvoked: (value) async => Get.offAll(const NavigationMenu()),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              /// -- Header
              MPrimaryHeaderContainer(
                child: Column(
                  children: [
                    /// AppBar
                    MAppBar(
                        title: Text('Tài Khoản',
                            style: Theme.of(context)
                                .textTheme
                                .headlineMedium!
                                .apply(color: MColors.white))),

                    /// User Profile Card
                    MUserProfileTile(
                        onPressed: () => Get.to(() => const ProfileScreen())),
                    const SizedBox(height: MSizes.spaceBtwSections),
                  ],
                ),
              ),

              /// -- Profile Body
              Padding(
                padding: const EdgeInsets.all(MSizes.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// -- Account  Settings
                    const MSectionHeading(
                        title: 'Cài đặt tài khoản', showActionButton: false),
                    const SizedBox(height: MSizes.spaceBtwItems),
                    MSettingsMenuTile(
                      icon: Iconsax.safe_home,
                      title: 'Địa chỉ',
                      subTitle: 'Cài đặt địa chỉ giao hàng',
                      onTap: () => Get.to(() => const UserAddressScreen()),
                    ),
                    MSettingsMenuTile(
                      icon: Iconsax.shopping_cart,
                      title: 'Giỏ hàng của tôi',
                      subTitle: 'Thêm, xóa sản phẩm và chuyển sang thanh toán',
                      onTap: () => Get.to(() => const CartScreen()),
                    ),
                    MSettingsMenuTile(
                      icon: Iconsax.bag_tick,
                      title: 'Đơn hàng của tôi',
                      subTitle: 'Đơn hàng đang thực hiện và đã hoàn thành',
                      onTap: () => Get.to(() => const OrderScreen()),
                    ),
                    const MSettingsMenuTile(
                        icon: Iconsax.bank,
                        title: 'Tài khoản ngân hàng',
                        subTitle:
                            'Rút số dư về tài khoản ngân hàng đã đăng ký'),
                    const MSettingsMenuTile(
                        icon: Iconsax.discount_shape,
                        title: 'Mã giảm giá',
                        subTitle: 'Danh sách tất cả các mã giảm giá'),
                    MSettingsMenuTile(
                        icon: Iconsax.notification,
                        title: 'Thông báo',
                        subTitle: 'Cài đặt loại thông báo',
                        onTap: () {}),
                    const MSettingsMenuTile(
                        icon: Iconsax.security_card,
                        title: 'Quyền riêng tư tài khoản',
                        subTitle:
                            'Quản lý sử dụng dữ liệu và tài khoản được kết nối'),

                    /// -- App Settings
                    // const SizedBox(height: MSizes.spaceBtwSections),
                    // const MSectionHeading(
                    //     title: 'Cài đặt ứng dụng', showActionButton: false),
                    // const SizedBox(height: MSizes.spaceBtwItems),
                    // MSettingsMenuTile(
                    //   icon: Iconsax.document_upload,
                    //   title: 'Tải dữ liệu',
                    //   subTitle: 'Tải dữ liệu lên Firebase Cloud của bạn',
                    //   onTap: () => Get.to(() => const UploadDataScreen()),
                    // ),
                    // const SizedBox(height: MSizes.spaceBtwItems),
                    // MSettingsMenuTile(
                    //   icon: Iconsax.location,
                    //   title: 'Định vị',
                    //   subTitle: 'Cài đặt đề xuất dựa trên vị trí',
                    //   trailing: Switch(value: true, onChanged: (value) {}),
                    // ),
                    // MSettingsMenuTile(
                    //   icon: Iconsax.security_user,
                    //   title: 'Chế độ an toàn',
                    //   subTitle: 'Kết quả tìm kiếm an toàn cho mọi lứa tuổi',
                    //   trailing: Switch(value: false, onChanged: (value) {}),
                    // ),
                    // MSettingsMenuTile(
                    //   icon: Iconsax.image,
                    //   title: 'Chất lượng hình ảnh HD',
                    //   subTitle: 'Cài đặt chất lượng hình ảnh hiển thị',
                    //   trailing: Switch(value: false, onChanged: (value) {}),
                    // ),

                    /// -- Logout Button
                    const SizedBox(height: MSizes.spaceBtwSections),
                    SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                            onPressed: () => controller.logout(),
                            child: const Text('Đăng xuất'))),
                    const SizedBox(height: MSizes.spaceBtwSections * 2.5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
