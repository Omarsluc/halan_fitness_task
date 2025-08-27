part of 'progress_cubit.dart';

enum ProgressStatus { initial, loading, success, error }

class ProgressState extends Equatable {
  final ProgressStatus status;
  final List<Workout> workouts;
  final Map<String, int> weeklyFrequency;
  final Map<String, int> bodyPartDistribution;
  final int totalWorkouts;
  final int totalDuration;
  final int thisWeekWorkouts;
  final int thisWeekDuration;
  final String? errorMessage;

  const ProgressState({
    this.status = ProgressStatus.initial,
    this.workouts = const [],
    this.weeklyFrequency = const {},
    this.bodyPartDistribution = const {},
    this.totalWorkouts = 0,
    this.totalDuration = 0,
    this.thisWeekWorkouts = 0,
    this.thisWeekDuration = 0,
    this.errorMessage,
  });

  ProgressState copyWith({
    ProgressStatus? status,
    List<Workout>? workouts,
    Map<String, int>? weeklyFrequency,
    Map<String, int>? bodyPartDistribution,
    int? totalWorkouts,
    int? totalDuration,
    int? thisWeekWorkouts,
    int? thisWeekDuration,
    String? errorMessage,
  }) {
    return ProgressState(
      status: status ?? this.status,
      workouts: workouts ?? this.workouts,
      weeklyFrequency: weeklyFrequency ?? this.weeklyFrequency,
      bodyPartDistribution: bodyPartDistribution ?? this.bodyPartDistribution,
      totalWorkouts: totalWorkouts ?? this.totalWorkouts,
      totalDuration: totalDuration ?? this.totalDuration,
      thisWeekWorkouts: thisWeekWorkouts ?? this.thisWeekWorkouts,
      thisWeekDuration: thisWeekDuration ?? this.thisWeekDuration,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status,
    workouts,
    weeklyFrequency,
    bodyPartDistribution,
    totalWorkouts,
    totalDuration,
    thisWeekWorkouts,
    thisWeekDuration,
    errorMessage,
  ];
}
