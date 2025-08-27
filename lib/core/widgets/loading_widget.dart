import 'package:flutter/material.dart';
import '../theming/colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(ColorsManager.primaryColor),
      strokeWidth: 3,
    );
  }
}
