import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theming/colors.dart';

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
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.primaryColor.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: selectedBodyPart,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: ColorsManager.darkColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                    labelText: 'Body Part',
                    prefixIcon: Icon(
                      Icons.accessibility_new,
                      color: ColorsManager.primaryColor,
                      size: 20.sp,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: ColorsManager.primaryColor.withOpacity(0.3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: ColorsManager.primaryColor.withOpacity(0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: ColorsManager.primaryColor, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: bodyParts.map((part) {
                    return DropdownMenuItem(
                      value: part,
                      child: Text(
                        part,
                        style: TextStyle(
                          color: ColorsManager.darkColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: onBodyPartChanged,
                  dropdownColor: Colors.white,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: ColorsManager.primaryColor,
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: ColorsManager.primaryColor.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  value: selectedEquipment,
                  decoration: InputDecoration(
                    labelStyle: TextStyle(
                      color: ColorsManager.darkColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                    labelText: 'Equipment',
                    prefixIcon: Icon(
                      Icons.fitness_center,
                      color: ColorsManager.primaryColor,
                      size: 20.sp,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: ColorsManager.primaryColor.withOpacity(0.3)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: ColorsManager.primaryColor.withOpacity(0.3)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                      borderSide: BorderSide(color: ColorsManager.primaryColor, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: equipment.map((eq) {
                    return DropdownMenuItem(
                      value: eq,
                      child: Text(
                        eq,
                        style: TextStyle(
                          color: ColorsManager.darkColor,
                          fontSize: 14.sp,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: onEquipmentChanged,
                  dropdownColor: Colors.white,
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: ColorsManager.primaryColor,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (selectedBodyPart != null || selectedEquipment != null)
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: ColorsManager.primaryColor.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: TextButton.icon(
                  onPressed: onClearFilters,
                  icon: Icon(
                    Icons.clear,
                    color: ColorsManager.primaryColor,
                    size: 18.sp,
                  ),
                  label: Text(
                    'Clear Filters',
                    style: TextStyle(
                      color: ColorsManager.primaryColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}