import 'package:antrakuserinc/ui/values/dimens.dart';
import 'package:antrakuserinc/ui/values/my_colors.dart';
import 'package:antrakuserinc/ui/values/size_config.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../values/my_imgs.dart';

class AddButton extends StatelessWidget {
  final double height;
  final double width;
  final double? roundCorner;
  final String text;
  final double? fontSize;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;
  void Function() onPressed;

  AddButton({
    required this.height,
    required this.width,
    required this.text,
    this.fontSize,
    this.borderColor,
    this.textColor,
    this.roundCorner,
    this.color,
    required this.onPressed,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var theme = Theme.of(context);
    var textTheme = theme.textTheme;
    var mediaQuery = MediaQuery.of(context).size;
    return MaterialButton(
      color: color == null ? MyColors.white : color,
      height: height,
      minWidth: width,
      shape: RoundedRectangleBorder(
        side: BorderSide(
            color: borderColor == null
                ? Get.theme.colorScheme.primary
                : borderColor!),
        borderRadius:
            BorderRadius.circular(roundCorner == null ? 5 : roundCorner!),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            MyImgs.add,
            width: getWidth(Dimens.size20),
            height: getHeight(Dimens.size20),
          ),
          SizedBox(
            width: getWidth(Dimens.size10),
          ),
          Text(
            text,
            style: TextStyle(
                color:
                    textColor == null ? theme.colorScheme.primary : textColor!,
                fontSize: fontSize == null ? 18 : fontSize,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
