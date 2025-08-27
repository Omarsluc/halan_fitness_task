import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';

class CustomErrorWidget extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const CustomErrorWidget({
    super.key,
    required this.message,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Error Icon with circular fitness style
            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: ColorsManager.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: ColorsManager.primaryColor.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.error_outline,
                color: ColorsManager.primaryColor,
                size: 48.sp,
              ),
            ),
            SizedBox(height: 20.h),

            // Error Text
            Text(
              "Oops! Something went wrong",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: ColorsManager.darkColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),

            // Custom error message
            Text(
              message,
              style: TextStyle(
                fontSize: 16.sp,
                color: ColorsManager.greyColor,
                height: 1.4,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),

            // Retry Button
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: ColorsManager.primaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton.icon(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsManager.primaryColor,
                  foregroundColor: ColorsManager.darkColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
                  elevation: 0,
                ),
                icon: Icon(
                  Icons.refresh,
                  size: 20.sp,
                ),
                label: Text(
                  "Try Again",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
