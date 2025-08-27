import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/colors.dart';
import 'progress_stats_card.dart';

class ProgressOverviewSection extends StatelessWidget {
  final int totalWorkouts;
  final int totalDuration;
  final int thisWeekWorkouts;
  final int thisWeekDuration;

  const ProgressOverviewSection({
    super.key,
    required this.totalWorkouts,
    required this.totalDuration,
    required this.thisWeekWorkouts,
    required this.thisWeekDuration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            ColorsManager.primaryColor.withOpacity(0.1),
            ColorsManager.primaryColor.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: ColorsManager.primaryColor.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.trending_up,
                  color: ColorsManager.darkColor,
                  size: 20.sp,
                ),
              ),
              SizedBox(width: 12.w),
              Text(
                'Progress Overview',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)
              ),
            ],
          ),
          SizedBox(height: 20.h),

          // Stats Cards
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 16.w,
            mainAxisSpacing: 16.h,
            childAspectRatio: .9,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeOutCubic,
                child: ProgressStatsCard(
                  title: 'Total Workouts',
                  value: totalWorkouts.toString(),
                  subtitle: 'All time',
                  icon: Icons.fitness_center,
                  color: ColorsManager.primaryColor,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutCubic,
                child: ProgressStatsCard(
                  title: 'Total Time',
                  value: '$totalDuration min',
                  subtitle: 'All time',
                  icon: Icons.timer,
                  color: ColorsManager.secondaryColor,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeOutCubic,
                child: ProgressStatsCard(
                  title: 'This Week',
                  value: thisWeekWorkouts.toString(),
                  subtitle: 'Workouts',
                  icon: Icons.calendar_today,
                  color: ColorsManager.greenColor,
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 600),
                curve: Curves.easeOutCubic,
                child: ProgressStatsCard(
                  title: 'Weekly Time',
                  value: '$thisWeekDuration min',
                  subtitle: 'This week',
                  icon: Icons.schedule,
                  color: ColorsManager.yellowColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
