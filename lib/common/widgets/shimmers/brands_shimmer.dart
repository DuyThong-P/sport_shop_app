import 'package:flutter/material.dart';
import '../layouts/grid_layout.dart';
import 'shimmer.dart';

class MBrandsShimmer extends StatelessWidget {
  const MBrandsShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return MGridLayout(
      mainAxisExtent: 80,
      itemCount: itemCount,
      itemBuilder: (_, __) => const MShimmerEffect(width: 300, height: 80),
    );
  }
}
