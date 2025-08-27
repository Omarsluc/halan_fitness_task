import '../model/progress_model.dart';

abstract class ProgressRepository {
  Future<void> saveProgress(Progress progress);
  Future<Progress?> getProgress(String userId);
  Future<void> updateProgress(Progress progress);
  Future<void> deleteProgress(String userId);
  Future<List<Progress>> getAllProgress();
}
