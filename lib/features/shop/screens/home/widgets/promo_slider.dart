import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/custom_shapes/containers/circular_container.dart';
import '../../../../../common/widgets/images/rounded_image.dart';
import '../../../../../common/widgets/shimmers/shimmer.dart';
import '../../../../../utils/contants/colors.dart';
import '../../../../../utils/contants/sizes.dart';
import '../../../controllers/product/banner_controller.dart';

/// Widget to display a promo slider using GetX state management.
class MPromoSlider extends StatelessWidget {
  const MPromoSlider({super.key});

  @override
  Widget build(BuildContext context) {
    // Get instance of BannerController using GetX
    final controller = Get.put(BannerController());

    // Use Obx widget to automatically rebuild the UI when banners state changes
    return Obx(
      () {
        // Loader
        if (controller.isLoading.value) {
          return const MShimmerEffect(width: double.infinity, height: 190);
        }

        // No data found
        if (controller.banners.isEmpty) {
          return const Center(child: Text('No Data Found!'));
        } else {
          return Column(
            children: [
              CarouselSlider(
                  options: CarouselOptions(
                      viewportFraction: 1,
                      onPageChanged: (index, _) =>
                          controller.updatePageIndicator(index)),
                  items: controller.banners
                      .map((banner) => MRoundedImage(
                            imageUrl: banner.imageUrl,
                            isNetworkImage: true,
                            onPressed: () => Get.toNamed(banner.targetScreen),
                          ))
                      .toList()),
              const SizedBox(height: MSizes.spaceBtwItems),
              Center(
                child: Obx(
                  () => Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (int i = 0; i < controller.banners.length; i++)
                        MCircularContainer(
                          width: 20,
                          height: 4,
                          margin: const EdgeInsets.only(right: 10),
                          backgroundColor:
                              controller.carousalCurrentIndex.value == i
                                  ? MColors.primary
                                  : MColors.grey,
                        ),
                    ],
                  ),
                ),
              )
            ],
          );

          /// Record Found! 🎊
          // Display CarouselSlider with banners and page indicator
          // return Column(
          //   children: [
          //     CarouselSlider(
          //       options: CarouselOptions(
          //         /// Tự chạy banners
          //         autoPlay: true,
          //         autoPlayInterval: const Duration(
          //             seconds:
          //                 3), // Đặt thời gian giữa mỗi lần chuyển tiếp tự động là 3 giây.
          //         autoPlayAnimationDuration: const Duration(
          //             microseconds:
          //                 800), // Đặt thời gian mỗi lần chuyển đổi phần tử trong quá trình tự động phát là 800 microseconds.
          //         autoPlayCurve: Curves
          //             .fastOutSlowIn, // Sử dụng đường cong chuyển động nhanh ra chậm vào để tạo hiệu ứng chuyển động cho tự động phát.
          //         enlargeCenterPage:
          //             true, // Khi thiết lập là true, phần tử ở trung tâm sẽ được phóng to, tạo hiệu ứng nhấn mạnh hơn.
          //         aspectRatio: 16 / 9, //  Tỷ lệ khung hình
          //         viewportFraction:
          //             1, // Tỷ lệ của phần tử hiển thị so với kích thước của viewport
          //         onPageChanged: (index, _) =>
          //             controller.updatePageIndicator(index),
          //       ),
          //       items: controller.banners
          //           .map((banner) => MRoundedImage(
          //                 imageUrl: banner.imageUrl,
          //                 isNetworkImage: true,
          //                 onPressed: () => Get.toNamed(banner.targetScreen),
          //               ))
          //           .toList(),
          //     ),
          //     const SizedBox(height: MSizes.spaceBtwItems),
          //     Center(
          //       child: Obx(
          //         () => Row(
          //           mainAxisSize: MainAxisSize.min,
          //           children: [
          //             // Display page indicators based on the number of banners
          //             for (int i = 0; i < controller.banners.length; i++)
          //               MCircularContainer(
          //                 width: 20,
          //                 height: 4,
          //                 margin: const EdgeInsets.only(right: 10),
          //                 backgroundColor:
          //                     controller.carousalCurrentIndex.value == i
          //                         ? MColors.primary
          //                         : MColors.grey,
          //               ),
          //           ],
          //         ),
          //       ),
          //     ),
          //   ],
          // );
        }
      },
    );
  }
}
