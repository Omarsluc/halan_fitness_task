import 'package:equatable/equatable.dart';
import '../../dashboard/data/model/exercise_model.dart';

enum ExerciseDetailStatus { initial, loading, success, logging, logged, error }

class ExerciseDetailState extends Equatable {
  final ExerciseDetailStatus status;
  final Exercise? exercise;
  final String? errorMessage;

  const ExerciseDetailState({
    this.status = ExerciseDetailStatus.initial,
    this.exercise,
    this.errorMessage,
  });

  ExerciseDetailState copyWith({
    ExerciseDetailStatus? status,
    Exercise? exercise,
    String? errorMessage,
  }) {
    return ExerciseDetailState(
      status: status ?? this.status,
      exercise: exercise ?? this.exercise,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, exercise, errorMessage];
}
