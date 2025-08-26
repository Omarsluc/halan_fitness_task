import '../model/workout_model.dart';

abstract class WorkoutRepository {
  Future<void> logWorkout(Workout workout);
  Future<List<Workout>> getWorkouts();
  Future<List<Workout>> getWorkoutsByDateRange(DateTime start, DateTime end);
  Future<void> deleteWorkout(String id);
  Future<Map<String, int>> getWeeklyFrequency();
  Future<Map<String, int>> getBodyPartDistribution();
}