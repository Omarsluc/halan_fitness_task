import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/services/notifications_service.dart';
import '../../dashboard/data/repo/exercise_repo.dart';
import '../../progress/data/model/workout_model.dart';
import '../../progress/data/repo/workout_repo.dart';
import 'exercise_details_state.dart';

class ExerciseDetailCubit extends Cubit<ExerciseDetailState> {
  final ExerciseRepository _exerciseRepository;
  final WorkoutRepository _workoutRepository;
  final NotificationService _notificationService;

  ExerciseDetailCubit(this._exerciseRepository, this._workoutRepository,
      NotificationService notificationService)
      : _notificationService = notificationService,
        super(const ExerciseDetailState());

  Future<void> loadExercise(String id) async {
    emit(state.copyWith(status: ExerciseDetailStatus.loading));

    try {
      final exercise = await _exerciseRepository.getExerciseById(id);
      emit(state.copyWith(
        status: ExerciseDetailStatus.success,
        exercise: exercise,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ExerciseDetailStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> logWorkout(int durationMinutes) async {
    if (state.exercise == null || durationMinutes <= 0) {
      emit(state.copyWith(
        status: ExerciseDetailStatus.error,
        errorMessage: 'Invalid workout data',
      ));
      return;
    }

    emit(state.copyWith(status: ExerciseDetailStatus.logging));

    try {
      final workout = Workout(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        exerciseName: state.exercise!.name,
        exerciseId: state.exercise!.id,
        duration: durationMinutes,
        date: DateTime.now(),
        bodyPart: state.exercise!.bodyPart,
        equipment: state.exercise!.equipment,
        target: state.exercise!.target,
      );

      await _workoutRepository.logWorkout(workout);
      await _notificationService.showWorkoutCompleted();

      emit(state.copyWith(status: ExerciseDetailStatus.logged));

      // Reset to success after showing logged state
      Future.delayed(const Duration(seconds: 2), () {
        if (!isClosed) {
          emit(state.copyWith(status: ExerciseDetailStatus.success));
        }
      });
    } catch (e) {
      emit(state.copyWith(
        status: ExerciseDetailStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }
}
