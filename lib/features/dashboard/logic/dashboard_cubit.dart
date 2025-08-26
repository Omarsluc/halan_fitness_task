import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/exercise_repo.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final ExerciseRepository _exerciseRepository;
  Timer? _debounceTimer;

  DashboardCubit(this._exerciseRepository) : super(const DashboardState());

  Future<void> loadExercises() async {
    emit(state.copyWith(status: DashboardStatus.loading));

    try {
      final exercises = await _exerciseRepository.getExercises();
      emit(state.copyWith(
        status: DashboardStatus.success,
        exercises: exercises,
        filteredExercises: exercises,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DashboardStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void searchExercises(String query) {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _performSearch(query);
    });
  }

  Future<void> _performSearch(String query) async {
    if (query.isEmpty) {
      emit(state.copyWith(
        filteredExercises: state.exercises,
        searchQuery: '',
      ));
      return;
    }

    emit(state.copyWith(
      status: DashboardStatus.loading,
      searchQuery: query,
    ));

    try {
      final exercises = await _exerciseRepository.searchExercises(query);
      emit(state.copyWith(
        status: DashboardStatus.success,
        filteredExercises: exercises,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: DashboardStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  void filterByBodyPart(String? bodyPart) {
    if (bodyPart == null || bodyPart.isEmpty) {
      emit(state.copyWith(
        filteredExercises: state.exercises,
        selectedBodyPart: null,
      ));
      return;
    }

    final filtered = state.exercises.where((exercise) =>
    exercise?.bodyPart.toLowerCase() == bodyPart.toLowerCase()
    ).toList();

    emit(state.copyWith(
      filteredExercises: filtered,
      selectedBodyPart: bodyPart,
    ));
  }

  void filterByEquipment(String? equipment) {
    if (equipment == null || equipment.isEmpty) {
      emit(state.copyWith(
        filteredExercises: state.exercises,
        selectedEquipment: null,
      ));
      return;
    }

    final filtered = state.exercises.where((exercise) =>
    exercise.equipment.toLowerCase() == equipment.toLowerCase()
    ).toList();

    emit(state.copyWith(
      filteredExercises: filtered,
      selectedEquipment: equipment,
    ));
  }

  void clearFilters() {
    emit(state.copyWith(
      filteredExercises: state.exercises,
      selectedBodyPart: null,
      selectedEquipment: null,
      searchQuery: '',
    ));
  }

  @override
  Future<void> close() {
    _debounceTimer?.cancel();
    return super.close();
  }
}
