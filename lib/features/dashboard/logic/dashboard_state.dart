import 'package:equatable/equatable.dart';
import '../data/model/exercise_model.dart';

enum DashboardStatus { initial, loading, success, error }

class DashboardState extends Equatable {
  final DashboardStatus status;
  final List<Exercise> exercises;
  final List<Exercise> filteredExercises;
  final String searchQuery;
  final String? selectedBodyPart;
  final String? selectedEquipment;
  final String? errorMessage;

  const DashboardState({
    this.status = DashboardStatus.initial,
    this.exercises = const [],
    this.filteredExercises = const [],
    this.searchQuery = '',
    this.selectedBodyPart,
    this.selectedEquipment,
    this.errorMessage,
  });

  DashboardState copyWith({
    DashboardStatus? status,
    List<Exercise>? exercises,
    List<Exercise>? filteredExercises,
    String? searchQuery,
    String? selectedBodyPart,
    String? selectedEquipment,
    String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      exercises: exercises ?? this.exercises,
      filteredExercises: filteredExercises ?? this.filteredExercises,
      searchQuery: searchQuery ?? this.searchQuery,
      selectedBodyPart: selectedBodyPart ?? this.selectedBodyPart,
      selectedEquipment: selectedEquipment ?? this.selectedEquipment,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    status, exercises, filteredExercises, searchQuery,
    selectedBodyPart, selectedEquipment, errorMessage,
  ];
}
