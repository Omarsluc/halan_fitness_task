// lib/features/dashboard/logic/dashboard_cubit.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/repo/exercise_repo.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final ExerciseRepository _exerciseRepository;
  Timer? _debounceTimer;

  DashboardCubit(this._exerciseRepository) : super(const DashboardState());

}
