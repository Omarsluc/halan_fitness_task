
import '../model/exercise_model.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> getExercises({int offset = 0, int limit = 20});
  Future<List<Exercise>> searchExercises(String query);
  Future<Exercise> getExerciseById(String id);
  Future<List<Exercise>> getExercisesByBodyPart(String bodyPart);
  Future<List<Exercise>> getExercisesByEquipment(String equipment);
  Future<List<Exercise>> getExercisesByTarget(String target);
}
