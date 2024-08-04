import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/texts/section_heading.dart';
import '../../../../utils/contants/colors.dart';
import '../../../../utils/contants/sizes.dart';
import '../../controllers/update_data_controller.dart';

class UploadDataScreen extends StatelessWidget {
  const UploadDataScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UploadDataController());
    return Scaffold(
      appBar:
          const MAppBar(title: Text('Cập nhật dữ liệu'), showBackArrow: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            /// -- Profile Body
            Padding(
              padding: const EdgeInsets.all(MSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const MSectionHeading(
                      title: 'Bản ghi', showActionButton: false),
                  const SizedBox(height: MSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.category,
                        size: 28, color: MColors.primary),
                    title: Text('Cập nhật danh mục',
                        style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadCategories(),
                      icon: const Icon(Iconsax.arrow_up_1,
                          size: 28, color: MColors.primary),
                    ),
                  ),
                  const SizedBox(height: MSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.shop,
                        size: 28, color: MColors.primary),
                    title: Text('Cập nhật thương hiệu',
                        style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadBrands(),
                      icon: const Icon(Iconsax.arrow_up_1,
                          size: 28, color: MColors.primary),
                    ),
                  ),
                  const SizedBox(height: MSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.shopping_cart,
                        size: 28, color: MColors.primary),
                    title: Text('Cập nhật sản phẩm',
                        style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadProducts(),
                      icon: const Icon(Iconsax.arrow_up_1,
                          size: 28, color: MColors.primary),
                    ),
                  ),
                  const SizedBox(height: MSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.image,
                        size: 28, color: MColors.primary),
                    title: Text('Upload Banners',
                        style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadBanners(),
                      icon: const Icon(Iconsax.arrow_up_1,
                          size: 28, color: MColors.primary),
                    ),
                  ),
                  const SizedBox(height: MSizes.spaceBtwSections),
                  const MSectionHeading(
                      title: 'Relationships', showActionButton: false),
                  const Text(
                      'Đảm bảo bạn đã tải lên tất cả nội dung bên trên.'),
                  const SizedBox(height: MSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.link,
                        size: 28, color: MColors.primary),
                    title: Text(
                        'Tải dữ liệu quan hệ giữa thương hiệu và danh mục',
                        style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadBrandCategory(),
                      icon: const Icon(Iconsax.arrow_up_1,
                          size: 28, color: MColors.primary),
                    ),
                  ),
                  const SizedBox(height: MSizes.spaceBtwItems),
                  ListTile(
                    leading: const Icon(Iconsax.link,
                        size: 28, color: MColors.primary),
                    title: Text('Tải dữ liệu quan hệ danh mục sản phẩm',
                        style: Theme.of(context).textTheme.titleMedium),
                    trailing: IconButton(
                      onPressed: () => controller.uploadProductCategories(),
                      icon: const Icon(Iconsax.arrow_up_1,
                          size: 28, color: MColors.primary),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
