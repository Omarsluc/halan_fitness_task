import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/colors.dart';
import 'workout_history_item.dart';
import '../../data/model/workout_model.dart';

class WorkoutHistorySection extends StatelessWidget {
  final List<Workout> workouts;
  final Function(String) onDelete;

  const WorkoutHistorySection({
    super.key,
    required this.workouts,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration:BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorsManager.primaryColor.withAlpha(10),
            ColorsManager.secondaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ColorsManager.primaryColor.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.primaryColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: ColorsManager.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.history,
                      color: ColorsManager.primaryColor,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Text(
                    'Workout History',
                    style: Theme.of(context).textTheme.titleSmall
                  ),
                ],
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${workouts.length} workouts',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: ColorsManager.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          if (workouts.isEmpty) _buildEmptyState() else _buildWorkoutList(),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: ColorsManager.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.fitness_center_outlined,
              size: 40.sp,
              color: ColorsManager.primaryColor,
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No workouts logged yet',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: ColorsManager.greyColor,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Complete your first workout to see your progress here!',
            style: TextStyle(
              fontSize: 14.sp,
              color: ColorsManager.greyColor.withOpacity(0.8),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        final workout = workouts[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: WorkoutHistoryItem(
            workout: workout,
            onDelete: () => onDelete(workout.id),
          ),
        );
      },
    );
  }
}
