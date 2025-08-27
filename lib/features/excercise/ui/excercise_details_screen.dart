import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halan_fitnessapp_task/core/utilites/dimensions.dart';
import 'package:halan_fitnessapp_task/core/widgets/app_button.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/theming/colors.dart';
import '../../../core/widgets/Loading_widget.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/log_exercise_dialog.dart';
import '../../../core/widgets/workout_success_animation.dart';
import '../../../core/widgets/exercise_share_dialog.dart';
import '../../dashboard/data/model/exercise_model.dart';
import '../logic/exercise_details_cubit.dart';
import '../logic/exercise_details_state.dart';

class ExerciseDetailScreen extends StatelessWidget {
  final String exerciseId;

  const ExerciseDetailScreen({
    super.key,
    required this.exerciseId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<ExerciseDetailCubit>()..loadExercise(exerciseId),
      child: const ExerciseDetailView(),
    );
  }
}

class ExerciseDetailView extends StatefulWidget {
  const ExerciseDetailView({super.key});

  @override
  State<ExerciseDetailView> createState() => _ExerciseDetailViewState();
}

class _ExerciseDetailViewState extends State<ExerciseDetailView> {
  bool _showSuccessAnimation = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Exercise Details',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        backgroundColor: ColorsManager.primaryColor.withOpacity(0.1),
        foregroundColor: ColorsManager.darkColor,
        elevation: 0,
        actions: [
          BlocBuilder<ExerciseDetailCubit, ExerciseDetailState>(
            builder: (context, state) {
              if (state.exercise != null) {
                return Container(
                  margin: EdgeInsets.only(right: 16.w),
                  decoration: BoxDecoration(
                    color: ColorsManager.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.share,
                      color: ColorsManager.primaryColor,
                      size: 20.sp,
                    ),
                    onPressed: () => _shareExercise(state.exercise!),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          BlocConsumer<ExerciseDetailCubit, ExerciseDetailState>(
            listener: (context, state) {
              if (state.status == ExerciseDetailStatus.logged) {
                setState(() {
                  _showSuccessAnimation = true;
                });
              } else if (state.status == ExerciseDetailStatus.error) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            state.errorMessage ?? 'Something went wrong',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: ColorsManager.errorFill,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                );
              }
            },
            builder: (context, state) {
              return _buildBody(context, state);
            },
          ),

          // Success Animation Overlay
          if (_showSuccessAnimation)
            WorkoutSuccessAnimation(
              onAnimationComplete: () {
                setState(() {
                  _showSuccessAnimation = false;
                });
                // Reset to success state after animation
                final currentExercise =
                    context.read<ExerciseDetailCubit>().state.exercise;
                if (currentExercise != null) {
                  context
                      .read<ExerciseDetailCubit>()
                      .loadExercise(currentExercise.id);
                }
              },
            ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context, ExerciseDetailState state) {
    switch (state.status) {
      case ExerciseDetailStatus.initial:
      case ExerciseDetailStatus.loading:
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
                  Icons.fitness_center,
                  size: 40.sp,
                  color: ColorsManager.primaryColor,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Loading exercise...',
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
      case ExerciseDetailStatus.error:
        return CustomErrorWidget(
          message: state.errorMessage ?? 'Failed to load exercise',
          onRetry: () => context.read<ExerciseDetailCubit>().loadExercise(''),
        );
      case ExerciseDetailStatus.success:
      case ExerciseDetailStatus.logging:
      case ExerciseDetailStatus.logged:
        final exercise = state.exercise!;
        return SingleChildScrollView(
          padding: EdgeInsets.all(16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Exercise Image Section
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.primaryColor.withOpacity(0.2),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: exercise.gifUrl,
                    height: 250.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 250.h,
                      width: double.infinity,
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
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.fitness_center,
                            size: 60.sp,
                            color: ColorsManager.primaryColor,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Loading exercise...',
                            style: TextStyle(
                              color: ColorsManager.primaryColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 250.h,
                      width: double.infinity,
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
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            size: 60.sp,
                            color: ColorsManager.primaryColor,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            'Image not available',
                            style: TextStyle(
                              color: ColorsManager.primaryColor,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              // Exercise Name
              Container(
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
                            Icons.fitness_center,
                            color: ColorsManager.darkColor,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            exercise.name.toUpperCase(),
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),

                    // Exercise Info Cards
                    _buildInfoCard(context, 'Body Part', exercise.bodyPart,
                        Icons.accessibility_new),
                    _buildInfoCard(context, 'Equipment', exercise.equipment,
                        Icons.fitness_center),
                    _buildInfoCard(
                        context, 'Target', exercise.target, Icons.my_location),

                    if (exercise.secondaryMuscles.isNotEmpty) ...[
                      SizedBox(height: 16.h),
                      _buildSecondaryMuscles(
                          context, exercise.secondaryMuscles),
                    ],
                  ],
                ),
              ),

              // Instructions
              SizedBox(height: 24.h),
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor.withAlpha(30),
                  borderRadius: BorderRadius.circular(20),
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
                      children: [
                        Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: ColorsManager.primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.list_alt,
                            color: ColorsManager.primaryColor,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Instructions',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    ...exercise.instructions.asMap().entries.map(
                          (entry) => Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 28.w,
                                  height: 28.h,
                                  decoration: BoxDecoration(
                                    color: ColorsManager.primaryColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: ColorsManager.primaryColor
                                            .withOpacity(0.3),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: Text(
                                      '${entry.key + 1}',
                                      style: TextStyle(
                                        color: ColorsManager.darkColor,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 16.w),
                                Expanded(
                                  child: Text(
                                    entry.value,
                                    style: Theme.of(context).textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w700)
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                  ],
                ),
              ),

              // Action Buttons
              SizedBox(height: 32.h),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.primaryColor.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: AppButton(
                  text: 'Log Workout',
                  onPressed: state.status == ExerciseDetailStatus.logging
                      ? null
                      : () => _showLogWorkoutDialog(context),
                  isLoading: state.status == ExerciseDetailStatus.logging,
                  horizontalPadding: 0,
                  verticalPadding: 20,
                ),
              ),
            ],
          ),
        );
    }
  }

  Widget _buildInfoCard(
      BuildContext context, String title, String value, IconData icon) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor.withAlpha(200),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ColorsManager.primaryColor.withOpacity(0.2),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.primaryColor.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: ColorsManager.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
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
                    fontSize: 12.sp,
                    color: ColorsManager.greyColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value.toUpperCase(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700)
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSecondaryMuscles(BuildContext context, List<String> muscles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                Icons.fitness_center,
                color: ColorsManager.primaryColor,
                size: 20.sp,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              'Secondary Muscles',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: ColorsManager.darkColor,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: muscles
              .map((muscle) => Container(
                    decoration: BoxDecoration(
                      color: ColorsManager.primaryColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: ColorsManager.primaryColor.withOpacity(0.3),
                        width: 1,
                      ),
                    ),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      child: Text(
                        muscle.toUpperCase(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: ColorsManager.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  void _showLogWorkoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => LogWorkoutDialog(
        onLogWorkout: (duration) {
          Navigator.of(dialogContext).pop();
          context.read<ExerciseDetailCubit>().logWorkout(duration);
        },
      ),
    );
  }

  void _shareExercise(Exercise exercise) {
    showDialog(
      context: context,
      builder: (context) => ExerciseShareDialog(exercise: exercise),
    );
  }
}
