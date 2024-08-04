import 'package:flutter/material.dart';

import 'curved_edges.dart';

class MCurvedEdgesWidget extends StatelessWidget {
  /// Create a widget with curved edges.
  const MCurvedEdgesWidget({
    super.key,
    required this.child,
  });

  /// The child widget to be wrapped with curved edges.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      // Use the custom clipper to create curved edges
      clipper: MCustomCurvedEdges(),
      child: child,
    );
  }
}
