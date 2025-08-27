import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../data/model/workout_model.dart';

class WorkoutHistoryItem extends StatelessWidget {
  final Workout workout;
  final VoidCallback? onDelete;

  const WorkoutHistoryItem({
    super.key,
    required this.workout,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          width: 50.w,
          height: 50.h,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(25),
          ),
          child: Icon(
            _getBodyPartIcon(workout.bodyPart),
            color: Theme.of(context).highlightColor,
            size: 24,
          ),
        ),
        title: Text(
          workout.exerciseName,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(
                  Icons.fitness_center,
                  size: 16.sp,
                  color: Colors.grey[600],
                ),
                 SizedBox(width: 4.w),
                Text(
                  workout.bodyPart,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(width: 16.w),
                Icon(
                  Icons.timer,
                  size: 16,
                  color: Colors.grey[600],
                ),
                SizedBox(width: 4.w),
                Text(
                  '${workout.duration} min',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              _formatDate(workout.date),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.grey[500],
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
        trailing: onDelete != null
            ? IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: onDelete,
              )
            : null,
      ),
    );
  }

  IconData _getBodyPartIcon(String bodyPart) {
    switch (bodyPart.toLowerCase()) {
      case 'chest':
        return Icons.fitness_center;
      case 'back':
        return Icons.accessibility_new;
      case 'shoulders':
        return Icons.accessibility;
      case 'arms':
        return Icons.accessibility_new;
      case 'legs':
        return Icons.directions_run;
      case 'core':
        return Icons.center_focus_strong;
      default:
        return Icons.fitness_center;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final workoutDate = DateTime(date.year, date.month, date.day);
    
    if (workoutDate == today) {
      return 'Today';
    } else if (workoutDate == today.subtract(const Duration(days: 1))) {
      return 'Yesterday';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }
}
