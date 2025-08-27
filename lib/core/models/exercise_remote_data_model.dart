import '../../features/dashboard/data/model/exercise_model.dart';
import '../api/api_client.dart';

class ExerciseRemoteDataSource {
  final ApiClient _apiClient;
  static const String _baseUrl = 'https://exercisedb.p.rapidapi.com';

  ExerciseRemoteDataSource(this._apiClient);

  String _constructImageUrl(String exerciseId) {
    return '$_baseUrl/exercises/exercise/$exerciseId/image';
  }

  Future<List<Exercise>> getExercises({int offset = 0, int limit = 20}) async {
    final response = await _apiClient.get(
      '/exercises',
      queryParameters: {'offset': offset, 'limit': limit},
    );

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) {
      final exercise = json as Map<String, dynamic>;
      // Construct image URL using exercise ID
      final exerciseId = exercise['id']?.toString() ?? '';
      if (exerciseId.isNotEmpty) {
        exercise['gifUrl'] = _constructImageUrl(exerciseId);
      }
      return Exercise.fromJson(exercise);
    }).toList();
  }

  Future<List<Exercise>> searchExercisesByName(String name) async {
    final response = await _apiClient.get('/exercises/name/$name');

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) {
      final exercise = json as Map<String, dynamic>;
      // Construct image URL using exercise ID
      final exerciseId = exercise['id']?.toString() ?? '';
      if (exerciseId.isNotEmpty) {
        exercise['gifUrl'] = _constructImageUrl(exerciseId);
      }
      return Exercise.fromJson(exercise);
    }).toList();
  }

  Future<Exercise> getExerciseById(String id) async {
    final response = await _apiClient.get('/exercises/exercise/$id');
    final exercise = response.data as Map<String, dynamic>;
    // Construct image URL using exercise ID
    exercise['gifUrl'] = _constructImageUrl(id);
    return Exercise.fromJson(exercise);
  }

  Future<List<Exercise>> getExercisesByBodyPart(String bodyPart) async {
    final response = await _apiClient.get('/exercises/bodyPart/$bodyPart');

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) {
      final exercise = json as Map<String, dynamic>;
      // Construct image URL using exercise ID
      final exerciseId = exercise['id']?.toString() ?? '';
      if (exerciseId.isNotEmpty) {
        exercise['gifUrl'] = _constructImageUrl(exerciseId);
      }
      return Exercise.fromJson(exercise);
    }).toList();
  }

  Future<List<Exercise>> getExercisesByEquipment(String equipment) async {
    final response = await _apiClient.get('/exercises/equipment/$equipment');

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) {
      final exercise = json as Map<String, dynamic>;
      // Construct image URL using exercise ID
      final exerciseId = exercise['id']?.toString() ?? '';
      if (exerciseId.isNotEmpty) {
        exercise['gifUrl'] = _constructImageUrl(exerciseId);
      }
      return Exercise.fromJson(exercise);
    }).toList();
  }

  Future<List<Exercise>> getExercisesByTarget(String target) async {
    final response = await _apiClient.get('/exercises/target/$target');

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) {
      final exercise = json as Map<String, dynamic>;
      // Construct image URL using exercise ID
      final exerciseId = exercise['id']?.toString() ?? '';
      if (exerciseId.isNotEmpty) {
        exercise['gifUrl'] = _constructImageUrl(exerciseId);
      }
      return Exercise.fromJson(exercise);
    }).toList();
  }

  /// Get all available body parts (categories)
  Future<List<String>> getBodyParts() async {
    final response = await _apiClient.get('/exercises/bodyPartList');
    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((part) => part.toString()).toList();
  }

  /// Get all available equipment types
  Future<List<String>> getEquipmentTypes() async {
    final response = await _apiClient.get('/exercises/equipmentList');
    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((equipment) => equipment.toString()).toList();
  }

  /// Get all available target muscles
  Future<List<String>> getTargetMuscles() async {
    final response = await _apiClient.get('/exercises/targetList');
    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((target) => target.toString()).toList();
  }
}
