import 'package:equatable/equatable.dart';

class Progress extends Equatable {
  final String id;
  final String userId;
  final int weeklyGoal;
  final int monthlyGoal;
  final int totalWorkouts;
  final int totalDuration;
  final DateTime lastWorkoutDate;
  final List<String> achievements;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Progress({
    required this.id,
    required this.userId,
    this.weeklyGoal = 3,
    this.monthlyGoal = 12,
    this.totalWorkouts = 0,
    this.totalDuration = 0,
    required this.lastWorkoutDate,
    this.achievements = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      id: json['id']?.toString() ?? '',
      userId: json['userId']?.toString() ?? '',
      weeklyGoal: json['weeklyGoal'] as int? ?? 3,
      monthlyGoal: json['monthlyGoal'] as int? ?? 12,
      totalWorkouts: json['totalWorkouts'] as int? ?? 0,
      totalDuration: json['totalDuration'] as int? ?? 0,
      lastWorkoutDate: DateTime.parse(json['lastWorkoutDate'] as String),
      achievements: List<String>.from(json['achievements'] ?? []),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'weeklyGoal': weeklyGoal,
      'monthlyGoal': monthlyGoal,
      'totalWorkouts': totalWorkouts,
      'totalDuration': totalDuration,
      'lastWorkoutDate': lastWorkoutDate.toIso8601String(),
      'achievements': achievements,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Progress copyWith({
    String? id,
    String? userId,
    int? weeklyGoal,
    int? monthlyGoal,
    int? totalWorkouts,
    int? totalDuration,
    DateTime? lastWorkoutDate,
    List<String>? achievements,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Progress(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      weeklyGoal: weeklyGoal ?? this.weeklyGoal,
      monthlyGoal: monthlyGoal ?? this.monthlyGoal,
      totalWorkouts: totalWorkouts ?? this.totalWorkouts,
      totalDuration: totalDuration ?? this.totalDuration,
      lastWorkoutDate: lastWorkoutDate ?? this.lastWorkoutDate,
      achievements: achievements ?? this.achievements,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        weeklyGoal,
        monthlyGoal,
        totalWorkouts,
        totalDuration,
        lastWorkoutDate,
        achievements,
        createdAt,
        updatedAt,
      ];
}
