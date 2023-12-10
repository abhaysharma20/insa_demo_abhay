import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class GradientButton extends StatelessWidget {
  final dynamic onClicked;
  final String? buttonText;
  final Color? color1;
  final Color? color2;
  final Color? color3;
  final Color? color4;
  final Color? textColor;
  final Widget? buttonIcon;
  final double? buttonWidth;
  final double? buttonHeight;

  const GradientButton(
      {super.key,
      required this.onClicked,
      this.buttonText,
      this.color1,
      this.color2,
      this.textColor,
      this.buttonIcon,
      this.buttonWidth,
      this.buttonHeight,
      this.color3,
      this.color4});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: buttonWidth ?? Get.width / 2.5,
      height: buttonHeight ?? 5.5.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color1 ?? const Color(0xFFFFFFFF),
            color2 ?? const Color(0xFFFFFFFF),
            color3 ?? const Color(0xFFFFFFFF),
            color4 ?? const Color(0xFFFAAA52),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        child: FilledButton(
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.transparent),
              backgroundColor: MaterialStateProperty.all(Colors.transparent)),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            child: Row(
              children: [
                buttonIcon ?? Container(),
                SizedBox(width: 1.5.w),
                Text(
                  buttonText!,
                  style: TextStyle(
                    color: textColor!,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          onPressed: () {
            onClicked(context);
          },
        ),
      ),
    );
  }
}
