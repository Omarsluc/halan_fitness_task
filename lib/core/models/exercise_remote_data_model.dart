

import '../../features/dashboard/data/model/exercise_model.dart';
import '../api/api_client.dart';

class ExerciseRemoteDataSource {
  final ApiClient _apiClient;
  static const String _baseUrl = 'https://exercisedb.p.rapidapi.com';

  ExerciseRemoteDataSource(this._apiClient);

  String _constructFullUrl(String? gifUrl) {
    if (gifUrl == null || gifUrl.isEmpty) return '';
    if (gifUrl.startsWith('http')) return gifUrl;
    return '$_baseUrl$gifUrl';
  }

  Future<List<Exercise>> getExercises({int offset = 0, int limit = 20}) async {
    final response = await _apiClient.get(
      '/exercises',
      queryParameters: {'offset': offset, 'limit': limit},
    );

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) {
      final exercise = json as Map<String, dynamic>;
      // Ensure gifUrl is a full URL
      if (exercise['gifUrl'] != null) {
        exercise['gifUrl'] = _constructFullUrl(exercise['gifUrl']);
      }
      return Exercise.fromJson(exercise);
    }).toList();
  }

  Future<List<Exercise>> searchExercisesByName(String name) async {
    final response = await _apiClient.get('/exercises/name/$name');

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) {
      final exercise = json as Map<String, dynamic>;
      // Ensure gifUrl is a full URL
      if (exercise['gifUrl'] != null) {
        exercise['gifUrl'] = _constructFullUrl(exercise['gifUrl']);
      }
      return Exercise.fromJson(exercise);
    }).toList();
  }

  Future<Exercise> getExerciseById(String id) async {
    final response = await _apiClient.get('/exercises/exercise/$id');
    final exercise = response.data as Map<String, dynamic>;
    // Ensure gifUrl is a full URL
    if (exercise['gifUrl'] != null) {
      exercise['gifUrl'] = _constructFullUrl(exercise['gifUrl']);
    }
    return Exercise.fromJson(exercise);
  }

  Future<List<Exercise>> getExercisesByBodyPart(String bodyPart) async {
    final response = await _apiClient.get('/exercises/bodyPart/$bodyPart');

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) {
      final exercise = json as Map<String, dynamic>;
      // Ensure gifUrl is a full URL
      if (exercise['gifUrl'] != null) {
        exercise['gifUrl'] = _constructFullUrl(exercise['gifUrl']);
      }
      return Exercise.fromJson(exercise);
    }).toList();
  }

  Future<List<Exercise>> getExercisesByEquipment(String equipment) async {
    final response = await _apiClient.get('/exercises/equipment/$equipment');

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) {
      final exercise = json as Map<String, dynamic>;
      // Ensure gifUrl is a full URL
      if (exercise['gifUrl'] != null) {
        exercise['gifUrl'] = _constructFullUrl(exercise['gifUrl']);
      }
      return Exercise.fromJson(exercise);
    }).toList();
  }

  Future<List<Exercise>> getExercisesByTarget(String target) async {
    final response = await _apiClient.get('/exercises/target/$target');

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) {
      final exercise = json as Map<String, dynamic>;
      // Ensure gifUrl is a full URL
      if (exercise['gifUrl'] != null) {
        exercise['gifUrl'] = _constructFullUrl(exercise['gifUrl']);
      }
      return Exercise.fromJson(exercise);
    }).toList();
  }
}