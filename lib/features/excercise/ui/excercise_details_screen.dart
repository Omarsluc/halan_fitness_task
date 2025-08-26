import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halan_fitnessapp_task/core/utilites/dimensions.dart';
import 'package:halan_fitnessapp_task/core/widgets/app_button.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/widgets/Loading_widget.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/log_exercise_dialog.dart';
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
      create: (context) => getIt<ExerciseDetailCubit>()..loadExercise(exerciseId),
      child: const ExerciseDetailView(),
    );
  }
}

class ExerciseDetailView extends StatelessWidget {
  const ExerciseDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exercise Details'),
        actions: [
          BlocBuilder<ExerciseDetailCubit, ExerciseDetailState>(
            builder: (context, state) {
              if (state.exercise != null) {
                return IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () => _shareExercise(state.exercise!),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocConsumer<ExerciseDetailCubit, ExerciseDetailState>(
        listener: (context, state) {
          if (state.status == ExerciseDetailStatus.logged) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Workout logged successfully! 💪'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state.status == ExerciseDetailStatus.error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Something went wrong'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          return _buildBody(context, state);
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, ExerciseDetailState state) {
    switch (state.status) {
      case ExerciseDetailStatus.initial:
      case ExerciseDetailStatus.loading:
        return const LoadingWidget();
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
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: exercise.gifUrl,
                    height: 200.h,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 200.h,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(Icons.fitness_center, size: 50),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Exercise Name
              Text(
                exercise.name.toUpperCase(),
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16.h),

              // Exercise Info Cards
              _buildInfoCard(context, 'Body Part', exercise.bodyPart, Icons.accessibility_new),
              _buildInfoCard(context, 'Equipment', exercise.equipment, Icons.fitness_center),
              _buildInfoCard(context, 'Target', exercise.target, Icons.my_location),

              if (exercise.secondaryMuscles.isNotEmpty) ...[
                SizedBox(height: 16.h),
                _buildSecondaryMuscles(context, exercise.secondaryMuscles),
              ],

              // Instructions
              SizedBox(height: 24.h),
              Text(
                'Instructions',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ...exercise.instructions.asMap().entries.map(
                    (entry) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 24.w,
                        height: 24.h,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${entry.key + 1}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Action Buttons
              SizedBox(height: 32.h),
              Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: 'Log Workout',
                      // icon: Icons.add_circle,
                      onPressed: state.status == ExerciseDetailStatus.logging
                          ? null
                          : () => _showLogWorkoutDialog(context),
                      isLoading: state.status == ExerciseDetailStatus.logging,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
    }
  }

  Widget _buildInfoCard(BuildContext context, String title, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(width: 12.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  Text(
                    value.toUpperCase(),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecondaryMuscles(BuildContext context, List<String> muscles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Secondary Muscles',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: muscles.map((muscle) => Chip(
            label: Text(
              muscle.toUpperCase(),
              style: const TextStyle(fontSize: 12),
            ),
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          )).toList(),
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

  void _shareExercise(exercise) {
    // Share.share(
    //   'Check out this exercise: ${exercise.name}\n'
    //       'Body Part: ${exercise.bodyPart}\n'
    //       'Equipment: ${exercise.equipment}\n'
    //       'Target: ${exercise.target}',
    // );
  }
}