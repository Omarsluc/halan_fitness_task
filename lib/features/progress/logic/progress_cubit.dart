import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../data/repo/workout_repo.dart';
import '../data/model/workout_model.dart';

part 'progress_state.dart';

class ProgressCubit extends Cubit<ProgressState> {
  final WorkoutRepository _workoutRepository;

  ProgressCubit(this._workoutRepository) : super(const ProgressState());

  Future<void> loadProgress() async {
    emit(state.copyWith(status: ProgressStatus.loading));

    try {
      final workouts = await _workoutRepository.getWorkouts();
      final weeklyFrequency = await _workoutRepository.getWeeklyFrequency();
      final bodyPartDistribution = await _workoutRepository.getBodyPartDistribution();
      
      // Calculate total workout time
      final totalDuration = workouts.fold<int>(0, (sum, workout) => sum + workout.duration);
      
      // Calculate this week's workouts
      final now = DateTime.now();
      final weekStart = now.subtract(Duration(days: now.weekday - 1));
      final weekEnd = weekStart.add(const Duration(days: 7));
      final thisWeekWorkouts = workouts.where((workout) => 
        workout.date.isAfter(weekStart.subtract(const Duration(days: 1))) &&
        workout.date.isBefore(weekEnd)
      ).toList();
      
      // Calculate this week's duration
      final thisWeekDuration = thisWeekWorkouts.fold<int>(0, (sum, workout) => sum + workout.duration);

      emit(state.copyWith(
        status: ProgressStatus.success,
        workouts: workouts,
        weeklyFrequency: weeklyFrequency,
        bodyPartDistribution: bodyPartDistribution,
        totalWorkouts: workouts.length,
        totalDuration: totalDuration,
        thisWeekWorkouts: thisWeekWorkouts.length,
        thisWeekDuration: thisWeekDuration,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProgressStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> deleteWorkout(String id) async {
    try {
      await _workoutRepository.deleteWorkout(id);
      // Reload progress after deletion
      await loadProgress();
    } catch (e) {
      emit(state.copyWith(
        status: ProgressStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> refreshProgress() async {
    await loadProgress();
  }
}
