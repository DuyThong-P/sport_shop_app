import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../../../../common/widgets/custom_shapes/containers/rounded_container.dart';
import '../../../../../utils/contants/colors.dart';
import '../../../../../utils/contants/sizes.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/address_controller.dart';
import '../../../models/address_model.dart';

class MSingleAddress extends StatelessWidget {
  const MSingleAddress({
    super.key,
    required this.address,
    required this.onTap,
  });

  final AddressModel address;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final controller = AddressController.instance;
    final dark = MHelperFunctions.isDarkMode(context);
    return Obx(
      () {
        final selectedAddressId = controller.selectedAddress.value.id;
        final isAddressSelected = selectedAddressId == address.id;
        return GestureDetector(
          onTap: onTap,
          child: MRoundedContainer(
            showBorder: true,
            padding: const EdgeInsets.all(MSizes.md),
            width: double.infinity,
            backgroundColor: isAddressSelected
                ? MColors.primary.withOpacity(0.5)
                : Colors.transparent,
            borderColor: isAddressSelected
                ? Colors.transparent
                : dark
                    ? MColors.darkerGrey
                    : MColors.grey,
            margin: const EdgeInsets.only(bottom: MSizes.spaceBtwItems),
            child: Stack(
              children: [
                Positioned(
                  right: 5,
                  top: 0,
                  child: Icon(
                    isAddressSelected
                        ? Iconsax.tick_circle1
                        : Iconsax.tick_circle1,
                    color: isAddressSelected
                        ? MColors.primary
                        : dark
                            ? MColors.darkerGrey
                            : MColors.grey,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: MSizes.sm / 2),
                    Text(address.formattedPhoneNo,
                        maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: MSizes.sm / 2),
                    Text(address.toString(), softWrap: true),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
