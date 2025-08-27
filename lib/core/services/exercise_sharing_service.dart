import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import '../../features/dashboard/data/model/exercise_model.dart';

class ExerciseSharingService {
  static final ExerciseSharingService _instance = ExerciseSharingService._internal();
  factory ExerciseSharingService() => _instance;
  ExerciseSharingService._internal();

  /// Share exercise as text with basic information
  static Future<void> shareExerciseAsText(Exercise exercise) async {
    final shareText = _buildExerciseText(exercise);
    
    try {
      await Share.share(
        shareText,
        subject: 'Check out this exercise: ${exercise.name}',
      );
    } catch (e) {
      debugPrint('Error sharing exercise: $e');
    }
  }

  /// Share exercise with detailed information
  static Future<void> shareExerciseDetailed(Exercise exercise) async {
    final shareText = _buildDetailedExerciseText(exercise);
    
    try {
      await Share.share(
        shareText,
        subject: 'Fitness Exercise: ${exercise.name}',
      );
    } catch (e) {
      debugPrint('Error sharing detailed exercise: $e');
    }
  }

  /// Share exercise with workout tips
  static Future<void> shareExerciseWithTips(Exercise exercise) async {
    final shareText = _buildExerciseWithTips(exercise);
    
    try {
      await Share.share(
        shareText,
        subject: 'Workout Tip: ${exercise.name}',
      );
    } catch (e) {
      debugPrint('Error sharing exercise with tips: $e');
    }
  }

  /// Share exercise as social media post
  static Future<void> shareExerciseSocial(Exercise exercise) async {
    final shareText = _buildSocialMediaText(exercise);
    
    try {
      await Share.share(
        shareText,
        subject: '💪 ${exercise.name}',
      );
    } catch (e) {
      debugPrint('Error sharing exercise socially: $e');
    }
  }

  /// Build basic exercise text for sharing
  static String _buildExerciseText(Exercise exercise) {
    return '''
🏃‍♂️ Exercise: ${exercise.name}

📍 Body Part: ${exercise.bodyPart}
🏋️ Equipment: ${exercise.equipment}
🎯 Target: ${exercise.target}

Try this exercise in your workout routine! 💪
    '''.trim();
  }

  /// Build detailed exercise text for sharing
  static String _buildDetailedExerciseText(Exercise exercise) {
    final instructions = exercise.instructions.take(3).join('\n• ');
    
    return '''
🏃‍♂️ ${exercise.name.toUpperCase()}

📍 Body Part: ${exercise.bodyPart}
🏋️ Equipment: ${exercise.equipment}
🎯 Target: ${exercise.target}

📋 Instructions:
• $instructions

${exercise.secondaryMuscles.isNotEmpty ? '💪 Secondary Muscles: ${exercise.secondaryMuscles.join(', ')}\n' : ''}
Perfect for building strength and improving fitness! 💪
    '''.trim();
  }

  /// Build exercise text with workout tips
  static String _buildExerciseWithTips(Exercise exercise) {
    return '''
💪 WORKOUT TIP: ${exercise.name.toUpperCase()}

🎯 Target: ${exercise.bodyPart}
🏋️ Equipment: ${exercise.equipment}

💡 Pro Tips:
• Start with 3 sets of 10-12 reps
• Focus on proper form
• Gradually increase weight
• Rest 60-90 seconds between sets

🔥 Challenge yourself and track your progress!
    '''.trim();
  }

  /// Build social media friendly text
  static String _buildSocialMediaText(Exercise exercise) {
    return '''
💪 Just discovered an amazing exercise!

🏃‍♂️ ${exercise.name}
📍 ${exercise.bodyPart} | 🏋️ ${exercise.equipment}

This exercise targets your ${exercise.target} and is perfect for building strength! 

#Fitness #Workout #${exercise.bodyPart.replaceAll(' ', '')} #Exercise #HealthyLifestyle

Try it out and let me know how it goes! 💪🔥
    '''.trim();
  }

  /// Share exercise with custom message
  static Future<void> shareExerciseCustom(
    Exercise exercise, {
    required String customMessage,
    String? hashtags,
  }) async {
    final shareText = '''
$customMessage

🏃‍♂️ ${exercise.name}
📍 ${exercise.bodyPart} | 🏋️ ${exercise.equipment} | 🎯 ${exercise.target}

${hashtags != null ? '\n$hashtags' : ''}
    '''.trim();
    
    try {
      await Share.share(
        shareText,
        subject: 'Fitness: ${exercise.name}',
      );
    } catch (e) {
      debugPrint('Error sharing custom exercise: $e');
    }
  }

  /// Share multiple exercises as a workout routine
  static Future<void> shareWorkoutRoutine(
    List<Exercise> exercises,
    String routineName,
  ) async {
    final exerciseList = exercises
        .asMap()
        .entries
        .map((entry) => '${entry.key + 1}. ${entry.value.name} (${entry.value.bodyPart})')
        .join('\n');

    final shareText = '''
💪 WORKOUT ROUTINE: $routineName

${exerciseList}

🔥 Complete this routine for a full-body workout!
💪 Stay consistent and track your progress!

#WorkoutRoutine #Fitness #HealthyLifestyle
    '''.trim();
    
    try {
      await Share.share(
        shareText,
        subject: 'Workout Routine: $routineName',
      );
    } catch (e) {
      debugPrint('Error sharing workout routine: $e');
    }
  }
}
