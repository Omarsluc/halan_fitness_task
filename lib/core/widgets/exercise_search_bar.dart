import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../theming/colors.dart';

class ExerciseSearchBar extends StatefulWidget {
  final ValueChanged<String> onSearch;

  const ExerciseSearchBar({
    super.key,
    required this.onSearch,
  });

  @override
  State<ExerciseSearchBar> createState() => _ExerciseSearchBarState();
}

class _ExerciseSearchBarState extends State<ExerciseSearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).scaffoldBackgroundColor.withAlpha(15),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Search exercises...',
          hintStyle: TextStyle(
            color: ColorsManager.greyColor.withOpacity(0.8),
            fontSize: 16.sp,
          ),
          prefixIcon: Container(
            margin: EdgeInsets.all(8.w),
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: ColorsManager.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              Icons.search,
              color: ColorsManager.primaryColor,
              size: 20.sp,
            ),
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? Container(
                  margin: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: ColorsManager.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: ColorsManager.primaryColor,
                      size: 20.sp,
                    ),
                    onPressed: () {
                      _controller.clear();
                      widget.onSearch('');
                    },
                  ),
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ColorsManager.primaryColor.withOpacity(0.3)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ColorsManager.primaryColor.withOpacity(0.3)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: BorderSide(color: ColorsManager.primaryColor, width: 2),
          ),
          filled: true,
          fillColor: Theme.of(context).scaffoldBackgroundColor.withAlpha(120),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        ),
        style: TextStyle(
          color: Theme.of(context).textTheme.bodyLarge?.color,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
        onChanged: widget.onSearch,
      ),
    );
  }
}