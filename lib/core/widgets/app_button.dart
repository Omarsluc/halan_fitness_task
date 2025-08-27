import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';
import 'Loading_widget.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool active;
  final Color? textColor;
  final double borderRadius;
  final TextStyle? textStyle;
  final IconData? leadingIcon;
  final double? horizontalPadding;
  final double? verticalPadding;

  const AppButton({
    Key? key,
    required this.text,
    this.active = true,
    required this.onPressed,
    this.isLoading = false,
    this.textColor,
    this.borderRadius = 12.0,
    this.textStyle,
    this.leadingIcon,
    this.horizontalPadding = 0,
    this.verticalPadding = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 80,
        vertical: verticalPadding ?? 15,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48.h,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: ColorsManager.primaryColor.withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: ElevatedButton(
            onPressed: isLoading || !active ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: active
                  ? ColorsManager.primaryColor
                  : ColorsManager.lightGreyColor,
              foregroundColor:
                  active ? ColorsManager.darkColor : ColorsManager.greyColor,
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            child: isLoading
                ? SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        active
                            ? ColorsManager.darkColor
                            : ColorsManager.greyColor,
                      ),
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (leadingIcon != null) ...[
                        Icon(
                          leadingIcon,
                          size: 20.sp,
                          color: active
                              ? ColorsManager.darkColor
                              : ColorsManager.greyColor,
                        ),
                        SizedBox(width: 8.w),
                      ],
                      Text(
                        text,
                        style: textStyle ??
                            TextStyle(
                              color: textColor ??
                                  (active
                                      ? ColorsManager.darkColor
                                      : ColorsManager.greyColor),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class AppOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool active;
  final Color? disabledColor;
  final double borderRadius;
  final TextStyle? textStyle;
  final IconData? leadingIcon;
  final double? horizontalPadding;
  final double? verticalPadding;
  final double borderWidth;

  const AppOutlinedButton({
    Key? key,
    required this.text,
    this.active = true,
    required this.onPressed,
    this.isLoading = false,
    this.disabledColor,
    this.borderRadius = 12.0,
    this.textStyle,
    this.leadingIcon,
    this.horizontalPadding = 0,
    this.verticalPadding = 15,
    this.borderWidth = 2.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding ?? 80,
        vertical: verticalPadding ?? 15,
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48.h,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: active
                ? [
                    BoxShadow(
                      color: ColorsManager.primaryColor.withOpacity(0.2),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: OutlinedButton(
            onPressed: isLoading || !active ? null : onPressed,
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: active
                    ? ColorsManager.primaryColor
                    : ColorsManager.greyColor.withOpacity(0.5),
                width: borderWidth,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              foregroundColor: active
                  ? ColorsManager.primaryColor
                  : ColorsManager.greyColor.withOpacity(0.5),
              padding: EdgeInsets.symmetric(vertical: 12.h),
              backgroundColor: active
                  ? ColorsManager.primaryColor.withOpacity(0.05)
                  : Colors.transparent,
            ),
            child: isLoading
                ? SizedBox(
                    height: 20.h,
                    width: 20.w,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        active
                            ? ColorsManager.primaryColor
                            : ColorsManager.greyColor.withOpacity(0.5),
                      ),
                      strokeWidth: 2,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (leadingIcon != null) ...[
                        Icon(
                          leadingIcon,
                          size: 20.sp,
                          color: active
                              ? ColorsManager.primaryColor
                              : ColorsManager.greyColor.withOpacity(0.5),
                        ),
                        SizedBox(width: 8.w),
                      ],
                      Text(
                        text,
                        style: textStyle ??
                            TextStyle(
                              color: active
                                  ? ColorsManager.primaryColor
                                  : ColorsManager.greyColor.withOpacity(0.5),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class SecondryAppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const SecondryAppButton({
    Key? key,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.secondaryColor.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.secondaryColor,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16.h),
          elevation: 0,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
