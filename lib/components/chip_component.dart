import 'package:flutter/material.dart';
import 'package:gpt/utils/app_colors.dart';


class ChipComponent extends StatelessWidget {
  final IconData iconData;
  final Widget text;
  const ChipComponent({super.key, required this.iconData, required this.text});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: AppColors.background2,
      color: AppColors.background2,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(iconData, size: 17, color: AppColors.colorTextInput),
            SizedBox(width: 8.0),
            text
          ],
        ),
      ),
    );
  }
}
