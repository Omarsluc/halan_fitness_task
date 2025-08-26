import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExerciseFilters extends StatelessWidget {
  final String? selectedBodyPart;
  final String? selectedEquipment;
  final ValueChanged<String?> onBodyPartChanged;
  final ValueChanged<String?> onEquipmentChanged;
  final VoidCallback onClearFilters;

  const ExerciseFilters({
    super.key,
    this.selectedBodyPart,
    this.selectedEquipment,
    required this.onBodyPartChanged,
    required this.onEquipmentChanged,
    required this.onClearFilters,
  });

  static const List<String> bodyParts = [
    'back', 'cardio', 'chest', 'lower arms', 'lower legs',
    'neck', 'shoulders', 'upper arms', 'upper legs', 'waist'
  ];

  static const List<String> equipment = [
    'assisted', 'band', 'barbell', 'body weight', 'bosu ball',
    'cable', 'dumbbell', 'elliptical machine', 'ez barbell',
    'hammer', 'kettlebell', 'leverage machine', 'medicine ball',
    'olympic barbell', 'resistance band', 'roller', 'rope',
    'skierg machine', 'sled machine', 'smith machine', 'stability ball',
    'stationary bike', 'stepmill machine', 'tire', 'trap bar', 'upper body ergometer',
    'weighted', 'wheel roller'
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<String>(
                value: selectedBodyPart,
                decoration: InputDecoration(
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  labelText: 'Body Part',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                  ),
                ),
                items: bodyParts.map((part) {
                  return DropdownMenuItem(
                    value: part,
                    child: Text(part),
                  );
                }).toList(),
                onChanged: onBodyPartChanged,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: DropdownButtonFormField<String>(
                isExpanded: true,
                value: selectedEquipment,
                decoration: InputDecoration(
                  labelStyle: Theme.of(context).textTheme.titleSmall,
                  labelText: 'Equipment',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12))
                  ),
                ),
                items: equipment.map((eq) {
                  return DropdownMenuItem(
                    value: eq,
                    child: Text(eq),
                  );
                }).toList(),
                onChanged: onEquipmentChanged,
              ),
            ),
          ],
        ),
        if (selectedBodyPart != null || selectedEquipment != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Align(
              alignment: Alignment.centerRight,
              child: TextButton.icon(
                onPressed: onClearFilters,
                icon: const Icon(Icons.clear),
                label: const Text('Clear Filters'),
              ),
            ),
          ),
      ],
    );
  }
}