import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/colors.dart';

class ProgressLoadingWidget extends StatelessWidget {
  const ProgressLoadingWidget({super.key});

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
            ),
            child: Icon(
              Icons.trending_up,
              size: 40.sp,
              color: ColorsManager.primaryColor,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'Loading progress...',
            style: TextStyle(
              fontSize: 16.sp,
              color: ColorsManager.greyColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            height: 50,
            width: 50,
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ColorsManager.primaryColor),
              strokeWidth: 3,
            ),
          ),
        ],
      ),
    );
  }
}
