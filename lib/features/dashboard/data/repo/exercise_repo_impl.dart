import '../../../../core/models/exercise_remote_data_model.dart';
import '../model/exercise_model.dart';
import 'exercise_repo.dart';

class ExerciseRepositoryImpl implements ExerciseRepository {
  final ExerciseRemoteDataSource _remoteDataSource;

  ExerciseRepositoryImpl(this._remoteDataSource);

  @override
  Future<List<Exercise>> getExercises({int offset = 0, int limit = 20}) async {
    return await _remoteDataSource.getExercises(offset: offset, limit: limit);
  }

  @override
  Future<List<Exercise>> searchExercises(String query) async {
    return await _remoteDataSource.searchExercisesByName(query);
  }

  @override
  Future<Exercise> getExerciseById(String id) async {
    return await _remoteDataSource.getExerciseById(id);
  }

  @override
  Future<List<Exercise>> getExercisesByBodyPart(String bodyPart) async {
    return await _remoteDataSource.getExercisesByBodyPart(bodyPart);
  }

  @override
  Future<List<Exercise>> getExercisesByEquipment(String equipment) async {
    return await _remoteDataSource.getExercisesByEquipment(equipment);
  }

  @override
  Future<List<Exercise>> getExercisesByTarget(String target) async {
    return await _remoteDataSource.getExercisesByTarget(target);
  }
}