import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theming/colors.dart';
import '../logic/progress_cubit.dart';
import 'widgets/weekly_chart.dart';
import 'widgets/progress_overview_section.dart';
import 'widgets/workout_history_section.dart';
import 'widgets/progress_loading_widget.dart';
import 'widgets/progress_error_widget.dart';
import 'widgets/progress_no_data_widget.dart';
import 'widgets/delete_workout_dialog.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  void initState() {
    super.initState();
    // Load progress data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProgressCubit>().loadProgress();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<ProgressCubit, ProgressState>(
        builder: (context, state) {
          if (state.status == ProgressStatus.loading) {
            return ProgressLoadingWidget();
          }

          if (state.status == ProgressStatus.error) {
            return ProgressErrorWidget(
              errorMessage: state.errorMessage ?? 'Unknown error occurred',
              onRetry: () {
                context.read<ProgressCubit>().loadProgress();
              },
            );
          }

          if (state.status == ProgressStatus.success) {
            return _buildProgressContent(context, state);
          }

          return ProgressNoDataWidget();
        },
      ),
    );
  }

  Widget _buildProgressContent(BuildContext context, ProgressState state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<ProgressCubit>().refreshProgress();
      },
      color: ColorsManager.primaryColor,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Progress Overview Section
            ProgressOverviewSection(
              totalWorkouts: state.totalWorkouts,
              totalDuration: state.totalDuration,
              thisWeekWorkouts: state.thisWeekWorkouts,
              thisWeekDuration: state.thisWeekDuration,
            ),

            SizedBox(height: 24.h),

            // Weekly Activity Chart
            WeeklyChart(weeklyFrequency: state.weeklyFrequency),

            SizedBox(height: 24.h),

            // Workout History Section
            WorkoutHistorySection(
              workouts: state.workouts,
              onDelete: (workoutId) => _showDeleteDialog(context, workoutId),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String workoutId) {
    final progressCubit = context.read<ProgressCubit>();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteWorkoutDialog(
          onConfirm: () {
            progressCubit.deleteWorkout(workoutId);
          },
        );
      },
    );
  }
}
