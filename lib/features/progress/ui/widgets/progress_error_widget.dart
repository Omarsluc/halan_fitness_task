import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/colors.dart';

class ProgressErrorWidget extends StatelessWidget {
  final String? errorMessage;
  final VoidCallback onRetry;

  const ProgressErrorWidget({
    super.key,
    this.errorMessage,
    required this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
              size: 40.sp,
              color: ColorsManager.primaryColor,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Error loading progress',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: ColorsManager.darkColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            errorMessage ?? 'Unknown error occurred',
            style: TextStyle(
              fontSize: 14.sp,
              color: ColorsManager.greyColor,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: ColorsManager.primaryColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorsManager.primaryColor,
                foregroundColor: ColorsManager.darkColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                elevation: 0,
              ),
              child: Text(
                'Retry',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
