import 'package:flutter/material.dart';

import '../../../utils/contants/colors.dart';
import '../../../utils/helpers/helper_functions.dart';
import '../custom_shapes/containers/circular_container.dart';

class MChoiceChip extends StatelessWidget {
  const MChoiceChip({
    super.key,
    required this.text,
    required this.selected,
    this.onSelected,
  });

  final String text;
  final bool selected;
  final void Function(bool)? onSelected;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
      child: ChoiceChip(
        // Use this function to get Colors as a Chip
        avatar: MHelperFunctions.getColor(text) != null
            ? MCircularContainer(
                width: 50,
                height: 50,
                backgroundColor: MHelperFunctions.getColor(text)!)
            : null,
        selected: selected,
        onSelected: onSelected,
        backgroundColor: MHelperFunctions.getColor(text),
        labelStyle: TextStyle(color: selected ? MColors.white : null),
        shape: MHelperFunctions.getColor(text) != null
            ? const CircleBorder()
            : null,
        label: MHelperFunctions.getColor(text) == null
            ? Text(text)
            : const SizedBox(),
        padding: MHelperFunctions.getColor(text) != null
            ? const EdgeInsets.all(0)
            : null,
        labelPadding: MHelperFunctions.getColor(text) != null
            ? const EdgeInsets.all(0)
            : null,
      ),
    );
  }
}
