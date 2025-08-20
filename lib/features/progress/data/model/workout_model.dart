import 'package:equatable/equatable.dart';

class Workout extends Equatable {
  final String id;
  final String exerciseName;
  final String exerciseId;
  final int duration;
  final DateTime date;
  final String bodyPart;
  final String equipment;
  final String target;

  const Workout({
    required this.id,
    required this.exerciseName,
    required this.exerciseId,
    required this.duration,
    required this.date,
    required this.bodyPart,
    required this.equipment,
    required this.target,
  });

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['id']?.toString() ?? '',
      exerciseName: json['exerciseName']?.toString() ?? '',
      exerciseId: json['exerciseId']?.toString() ?? '',
      duration: (json['duration'] as num?)?.toInt() ?? 0,
      date: DateTime.parse(json['date'] as String),
      bodyPart: json['bodyPart']?.toString() ?? '',
      equipment: json['equipment']?.toString() ?? '',
      target: json['target']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'exerciseName': exerciseName,
      'exerciseId': exerciseId,
      'duration': duration,
      'date': date.toIso8601String(),
      'bodyPart': bodyPart,
      'equipment': equipment,
      'target': target,
    };
  }

  @override
  List<Object> get props => [
    id, exerciseName, exerciseId, duration, date, bodyPart, equipment, target
  ];
}
