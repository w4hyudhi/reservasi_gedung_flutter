import 'package:flutter/material.dart';

import '../utils/color_resources.dart';
import '../utils/dimensions.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String? btnTxt;
  final TextStyle? textStyle;
  final Color? backgroundColor;
  CustomButton(
      {this.onTap,
      @required this.btnTxt,
      this.backgroundColor,
      this.textStyle});

  @override
  Widget build(BuildContext context) {
    final ButtonStyle flatButtonStyle = TextButton.styleFrom(
      backgroundColor: onTap == null
          ? ColorResources.COLOR_GRAY
          : backgroundColor == null
              ? Theme.of(context).primaryColor
              : backgroundColor,
      minimumSize: Size(MediaQuery.of(context).size.width, 50),
      padding: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );

    return TextButton(
      onPressed: onTap,
      style: flatButtonStyle,
      child: Text(btnTxt ?? "",
          style: textStyle ??
              Theme.of(context).textTheme.headline3?.copyWith(
                  color: ColorResources.COLOR_WHITE,
                  fontSize: Dimensions.FONT_SIZE_LARGE)),
    );
  }
}
