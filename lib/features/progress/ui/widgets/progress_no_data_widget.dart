import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/colors.dart';

class ProgressNoDataWidget extends StatelessWidget {
  const ProgressNoDataWidget({super.key});

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
            'No progress data available',
            style: TextStyle(
              fontSize: 18.sp,
              color: ColorsManager.greyColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
