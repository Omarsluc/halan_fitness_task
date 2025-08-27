import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';
import '../../features/dashboard/data/model/exercise_model.dart';
import '../services/exercise_sharing_service.dart';

class ExerciseShareDialog extends StatelessWidget {
  final Exercise exercise;

  const ExerciseShareDialog({
    super.key,
    required this.exercise,
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
            Icons.share_rounded,
            color: ColorsManager.primaryColor,
            size: 24.sp,
          ),
          SizedBox(width: 12.w),
          Text(
            'Share Exercise',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.bold,
              color: ColorsManager.darkColor,
            ),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Choose how you want to share "${exercise.name}"',
            style: TextStyle(
              fontSize: 14.sp,
              color: ColorsManager.darkColor.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20.h),
          _buildShareOption(
            context,
            icon: Icons.text_fields,
            title: 'Basic Info',
            subtitle: 'Share exercise name and details',
            onTap: () => _shareBasic(context),
          ),
          SizedBox(height: 8.h),
          _buildShareOption(
            context,
            icon: Icons.description,
            title: 'Detailed Info',
            subtitle: 'Include instructions and tips',
            onTap: () => _shareDetailed(context),
          ),
          SizedBox(height: 8.h),
          _buildShareOption(
            context,
            icon: Icons.lightbulb,
            title: 'With Tips',
            subtitle: 'Share workout tips and advice',
            onTap: () => _shareWithTips(context),
          ),
          SizedBox(height: 8.h),
          _buildShareOption(
            context,
            icon: Icons.people,
            title: 'Social Media',
            subtitle: 'Perfect for social platforms',
            onTap: () => _shareSocial(context),
          ),
          SizedBox(height: 8.h),
          _buildShareOption(
            context,
            icon: Icons.edit,
            title: 'Custom Message',
            subtitle: 'Add your own message',
            onTap: () => _showCustomShareDialog(context),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(
            'Cancel',
            style: TextStyle(
              color: ColorsManager.darkColor.withOpacity(0.6),
              fontSize: 14.sp,
            ),
          ),
        ),
      ],
      actionsPadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
    );
  }

  Widget _buildShareOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: ColorsManager.primaryColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: ColorsManager.primaryColor.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                color: ColorsManager.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                icon,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: ColorsManager.darkColor,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: ColorsManager.greyColor,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              size: 16.sp,
              color: ColorsManager.greyColor,
            ),
          ],
        ),
      ),
    );
  }

  void _shareBasic(BuildContext context) {
    Navigator.of(context).pop();
    ExerciseSharingService.shareExerciseAsText(exercise);
  }

  void _shareDetailed(BuildContext context) {
    Navigator.of(context).pop();
    ExerciseSharingService.shareExerciseDetailed(exercise);
  }

  void _shareWithTips(BuildContext context) {
    Navigator.of(context).pop();
    ExerciseSharingService.shareExerciseWithTips(exercise);
  }

  void _shareSocial(BuildContext context) {
    Navigator.of(context).pop();
    ExerciseSharingService.shareExerciseSocial(exercise);
  }

  void _showCustomShareDialog(BuildContext context) {
    Navigator.of(context).pop();
    _showCustomMessageDialog(context);
  }

  void _showCustomMessageDialog(BuildContext context) {
    final TextEditingController messageController = TextEditingController();
    final TextEditingController hashtagsController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            Icon(
              Icons.edit_rounded,
              color: ColorsManager.primaryColor,
              size: 24.sp,
            ),
            SizedBox(width: 12.w),
            Text(
              'Custom Message',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: ColorsManager.darkColor,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: messageController,
              decoration: InputDecoration(
                labelText: 'Your Message',
                hintText: 'Add your personal message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: ColorsManager.primaryColor,
                    width: 2,
                  ),
                ),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: hashtagsController,
              decoration: InputDecoration(
                labelText: 'Hashtags (Optional)',
                hintText: '#Fitness #Workout #Exercise',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: ColorsManager.primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: TextStyle(
                color: ColorsManager.darkColor.withOpacity(0.6),
                fontSize: 14.sp,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              final message = messageController.text.trim();
              final hashtags = hashtagsController.text.trim();
              
              if (message.isNotEmpty) {
                ExerciseSharingService.shareExerciseCustom(
                  exercise,
                  customMessage: message,
                  hashtags: hashtags.isNotEmpty ? hashtags : null,
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorsManager.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              'Share',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        actionsPadding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 20.h),
      ),
    );
  }
}
