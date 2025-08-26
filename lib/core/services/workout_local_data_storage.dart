import 'package:hive/hive.dart';

import '../../features/progress/data/model/workout_model.dart';

class WorkoutLocalDataSource {
  static const String _boxName = 'workouts';

  Future<Box<Map>> get _box async => await Hive.openBox<Map>(_boxName);

  Future<void> saveWorkout(Workout workout) async {
    final box = await _box;
    await box.put(workout.id, workout.toJson());
  }

  Future<List<Workout>> getAllWorkouts() async {
    final box = await _box;
    final workouts = <Workout>[];

    for (final json in box.values) {
      try {
        workouts.add(Workout.fromJson(Map<String, dynamic>.from(json)));
      } catch (e) {
        // Skip invalid entries
        continue;
      }
    }

    workouts.sort((a, b) => b.date.compareTo(a.date));
    return workouts;
  }

  Future<void> deleteWorkout(String id) async {
    final box = await _box;
    await box.delete(id);
  }

  Future<void> clearAllWorkouts() async {
    final box = await _box;
    await box.clear();
  }
}