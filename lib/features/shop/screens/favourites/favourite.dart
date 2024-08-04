import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sport_shop_app/navigation_menu.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/icons/circular_icon.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/loaders/animation_loader.dart';
import '../../../../common/widgets/products/product_card/product_card_vertical.dart';
import '../../../../common/widgets/shimmers/vertical_product_shimmer.dart';
import '../../../../utils/contants/image_strings.dart';
import '../../../../utils/contants/sizes.dart';
import '../../../../utils/device/device_utility.dart';
import '../../../../utils/helpers/cloud_helper_functions.dart';
import '../../controllers/product/favourites_controller.dart';
import '../store/store.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // Intercept the back button press and redirect to Home Screen
      onPopInvoked: (value) async => Get.offAll(const NavigationMenu()),
      child: Scaffold(
        appBar: MAppBar(
          title: Text('Yêu thích',
              style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            MCircularIcon(
                icon: Iconsax.add,
                onPressed: () => Get.to(() => const StoreScreen()))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(MSizes.defaultSpace),
            child: Column(
              children: [
                /// Products Grid
                Obx(() {
                  return FutureBuilder(
                    future: FavouritesController.instance.favoriteProducts(),
                    builder: (_, snapshot) {
                      /// Nothing Found Widget
                      final emptyWidget = MAnimationLoaderWidget(
                        text:
                            'Tạo danh sách yêu thích của riêng bạn\nTận hưởng niềm vui mua sắm ngay nào!',
                        animation: MImages.pencilAnimation,
                        showAction: true,
                        actionText: 'Thêm ngay',
                        onActionPressed: () =>
                            Get.off(() => const NavigationMenu()),
                      );
                      const loader = MVerticalProductShimmer(itemCount: 6);
                      final widget =
                          MCloudHelperFunctions.checkMultiRecordState(
                              snapshot: snapshot,
                              loader: loader,
                              nothingFound: emptyWidget);
                      if (widget != null) return widget;

                      final products = snapshot.data!;
                      return MGridLayout(
                        itemCount: products.length,
                        itemBuilder: (_, index) =>
                            MProductCardVertical(product: products[index]),
                      );
                    },
                  );
                }),
                SizedBox(
                    height: MDeviceUtils.getBottomNavigationBarHeight() +
                        MSizes.defaultSpace),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
