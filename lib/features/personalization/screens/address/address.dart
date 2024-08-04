import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sport_shop_app/utils/helpers/cloud_helper_functions.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../utils/contants/colors.dart';
import '../../../../utils/contants/sizes.dart';
import '../../controllers/address_controller.dart';
import 'add_new_address.dart';
import 'widgets/single_address.dart';

class UserAddressScreen extends StatelessWidget {
  const UserAddressScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    return Scaffold(
      appBar: MAppBar(
        showBackArrow: true,
        title:
            Text('Địa chỉ', style: Theme.of(context).textTheme.headlineSmall),
      ),
      body: Padding(
        padding: const EdgeInsets.all(MSizes.defaultSpace),
        child: Obx(
          () => FutureBuilder(
            // Use key to trigger refresh
            key: Key(controller.refreshData.value.toString()),
            future: controller.getAllUserAddresses(),
            builder: (_, snapshot) {
              /// Chức năng trợ giúp: Xử lý quá trình tải, không có bản ghi hoặc thông báo lỖI
              final response = MCloudHelperFunctions.checkMultiRecordState(
                  snapshot: snapshot);
              if (response != null) return response;

              final addresses = snapshot.data!;
              return ListView.builder(
                shrinkWrap: true,
                itemCount: addresses.length,
                itemBuilder: (_, index) => MSingleAddress(
                    address: addresses[index],
                    onTap: () => controller.selectAddress(addresses[index])),
              );
            },
          ),
        ),
      ),

      /// Thêm nút địa chỉ mới
      floatingActionButton: FloatingActionButton(
        backgroundColor: MColors.primary,
        onPressed: () => Get.to(() => const AddNewAddressScreen()),
        child: const Icon(Iconsax.add, color: MColors.white),
      ),
    );
  }
}
