import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theming/app_theme.dart';
import '../dashboard/ui/dashboard_screen.dart';
import '../progress/ui/progress_screen.dart';
import 'cubit/app_cubit.dart';
import 'cubit/app_state.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DashboardScreen(),
    const ProgressScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return MaterialApp(
              title: 'Fitness Tracker',
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: state.themeMode,
              home: Scaffold(
                body: IndexedStack(
                  index: _currentIndex,
                  children: _screens,
                ),
                bottomNavigationBar: NavigationBar(
                  selectedIndex: _currentIndex,
                  onDestinationSelected: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  destinations: const [
                    NavigationDestination(
                      icon: Icon(Icons.fitness_center),
                      label: 'Exercises',
                    ),
                    NavigationDestination(
                      icon: Icon(Icons.trending_up),
                      label: 'Progress',
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}