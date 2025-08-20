

import '../../features/dashboard/data/model/exercise_model.dart';
import '../api/api_client.dart';

class ExerciseRemoteDataSource {
  final ApiClient _apiClient;

  ExerciseRemoteDataSource(this._apiClient);

  Future<List<Exercise>> getExercises({int offset = 0, int limit = 20}) async {
    final response = await _apiClient.get(
      '/exercises',
      queryParameters: {'offset': offset, 'limit': limit},
    );

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) => Exercise.fromJson(json as Map<String, dynamic>)).toList();
  }

  Future<List<Exercise>> searchExercisesByName(String name) async {
    final response = await _apiClient.get('/exercises/name/$name');

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) => Exercise.fromJson(json as Map<String, dynamic>)).toList();
  }

  Future<Exercise> getExerciseById(String id) async {
    final response = await _apiClient.get('/exercises/exercise/$id');
    return Exercise.fromJson(response.data as Map<String, dynamic>);
  }

  Future<List<Exercise>> getExercisesByBodyPart(String bodyPart) async {
    final response = await _apiClient.get('/exercises/bodyPart/$bodyPart');

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) => Exercise.fromJson(json as Map<String, dynamic>)).toList();
  }

  Future<List<Exercise>> getExercisesByEquipment(String equipment) async {
    final response = await _apiClient.get('/exercises/equipment/$equipment');

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) => Exercise.fromJson(json as Map<String, dynamic>)).toList();
  }

  Future<List<Exercise>> getExercisesByTarget(String target) async {
    final response = await _apiClient.get('/exercises/target/$target');

    final List<dynamic> data = response.data as List<dynamic>;
    return data.map((json) => Exercise.fromJson(json as Map<String, dynamic>)).toList();
  }
}