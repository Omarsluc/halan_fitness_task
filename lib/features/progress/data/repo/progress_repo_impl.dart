import 'package:hive/hive.dart';
import '../model/progress_model.dart';
import 'progress_repo.dart';

class ProgressRepositoryImpl implements ProgressRepository {
  static const String _boxName = 'progress';

  Future<Box<Map>> get _box async => await Hive.openBox<Map>(_boxName);

  @override
  Future<void> saveProgress(Progress progress) async {
    final box = await _box;
    await box.put(progress.userId, progress.toJson());
  }

  @override
  Future<Progress?> getProgress(String userId) async {
    final box = await _box;
    final json = box.get(userId);
    if (json != null) {
      try {
        return Progress.fromJson(Map<String, dynamic>.from(json));
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  @override
  Future<void> updateProgress(Progress progress) async {
    await saveProgress(progress);
  }

  @override
  Future<void> deleteProgress(String userId) async {
    final box = await _box;
    await box.delete(userId);
  }

  @override
  Future<List<Progress>> getAllProgress() async {
    final box = await _box;
    final progressList = <Progress>[];

    for (final json in box.values) {
      try {
        progressList.add(Progress.fromJson(Map<String, dynamic>.from(json)));
      } catch (e) {
        continue;
      }
    }

    return progressList;
  }
}
