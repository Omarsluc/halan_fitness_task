import 'package:halan_fitnessapp_task/features/progress/data/repo/workout_repo.dart';
import '../../../../core/services/workout_local_data_storage.dart';
import '../model/workout_model.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutLocalDataSource _localDataSource;

  WorkoutRepositoryImpl(this._localDataSource);

  @override
  Future<void> logWorkout(Workout workout) async {
    await _localDataSource.saveWorkout(workout);
  }

  @override
  Future<List<Workout>> getWorkouts() async {
    return await _localDataSource.getAllWorkouts();
  }

  @override
  Future<List<Workout>> getWorkoutsByDateRange(DateTime start, DateTime end) async {
    final allWorkouts = await _localDataSource.getAllWorkouts();
    return allWorkouts.where((workout) {
      return workout.date.isAfter(start.subtract(const Duration(days: 1))) &&
          workout.date.isBefore(end.add(const Duration(days: 1)));
    }).toList();
  }

  @override
  Future<void> deleteWorkout(String id) async {
    await _localDataSource.deleteWorkout(id);
  }

  @override
  Future<Map<String, int>> getWeeklyFrequency() async {
    final allWorkouts = await _localDataSource.getAllWorkouts();
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 7));

    final weeklyWorkouts = allWorkouts.where((workout) {
      return workout.date.isAfter(weekAgo);
    }).toList();

    final frequency = <String, int>{};
    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      final dayKey = _getDayName(date.weekday);
      frequency[dayKey] = 0;
    }

    for (final workout in weeklyWorkouts) {
      final dayKey = _getDayName(workout.date.weekday);
      frequency[dayKey] = (frequency[dayKey] ?? 0) + 1;
    }

    return frequency;
  }

  @override
  Future<Map<String, int>> getBodyPartDistribution() async {
    final allWorkouts = await _localDataSource.getAllWorkouts();
    final distribution = <String, int>{};

    for (final workout in allWorkouts) {
      final key = workout.bodyPart.isNotEmpty ? workout.bodyPart : 'Unknown';
      distribution[key] = (distribution[key] ?? 0) + 1;
    }

    return distribution;
  }
}

String _getDayName(int weekday) {
  switch (weekday) {
    case DateTime.monday:
      return 'Mon';
    case DateTime.tuesday:
      return 'Tue';
    case DateTime.wednesday:
      return 'Wed';
    case DateTime.thursday:
      return 'Thu';
    case DateTime.friday:
      return 'Fri';
    case DateTime.saturday:
      return 'Sat';
    case DateTime.sunday:
      return 'Sun';
    default:
      return '';
  }
}