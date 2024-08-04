import 'package:flutter/material.dart';

import '../../../../utils/contants/colors.dart';
import '../curved_edges/curved_edges_widget.dart';
import 'circular_container.dart';

class MPrimaryHeaderContainer extends StatelessWidget {
  const MPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MCurvedEdgesWidget(
      child: Container(
        // color: MColors.primary,
        decoration: const BoxDecoration(
          gradient: MColors.linearGradient,
        ),
        padding: const EdgeInsets.only(bottom: 0),

        child: Stack(
          children: [
            /// -- Background Custom Shapes
            Positioned(
                top: -150,
                right: -250,
                child: MCircularContainer(
                    backgroundColor: MColors.textWhite.withOpacity(0.1))),
            Positioned(
                top: 100,
                right: -300,
                child: MCircularContainer(
                    backgroundColor: MColors.textWhite.withOpacity(0.1))),
            child,
          ],
        ),
      ),
    );
  }
}
