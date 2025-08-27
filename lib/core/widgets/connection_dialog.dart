import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';

class ConnectionDialog extends StatelessWidget {
  final VoidCallback? onRetry;

  const ConnectionDialog({
    super.key,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.r),
      ),
      title: Row(
        children: [
          Icon(
            Icons.wifi_off_rounded,
            color: ColorsManager.errorFill,
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Text(
            'No Internet Connection',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: ColorsManager.darkColor,
            ),
          ),
        ],
      ),
      content: Text(
        'Please check your internet connection and try again. Some features may not work without an internet connection.',
        style: TextStyle(
          fontSize: 14.sp,
          color: ColorsManager.darkColor.withOpacity(0.8),
          height: 1.4,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Close',
            style: TextStyle(
              color: ColorsManager.darkColor.withOpacity(0.6),
              fontSize: 14.sp,
            ),
          ),
        ),
        if (onRetry != null)
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              onRetry?.call();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 20.w,
                vertical: 12.h,
              ),
            ),
            child: Text(
              'Retry',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
      actionsPadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
    );
  }
}
