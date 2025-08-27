import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halan_fitnessapp_task/core/theming/colors.dart';

import '../../core/di/dependency_injection.dart';
import '../../core/theming/app_theme.dart';
import '../../core/widgets/theme_switcher.dart';
import '../../core/widgets/connection_wrapper.dart';
import '../dashboard/ui/dashboard_screen.dart';
import '../progress/ui/progress_screen.dart';
import '../progress/logic/progress_cubit.dart';
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
    BlocProvider(
      create: (context) => getIt<ProgressCubit>(),
      child: const ProgressScreen(),
    ),
  ];

  @override
  void initState() {
    super.initState();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

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
              home: ConnectionWrapper(
                onRetry: () {
                  // Refresh data when connection is restored
                  // This will trigger a refresh of the current screen
                },
                child: Scaffold(
                  appBar: AppBar(
                    scrolledUnderElevation: 0,
                    title: Row(
                      children: [
                        Icon(
                          Icons.fitness_center,
                          color: ColorsManager.primaryColor,
                          size: 24.sp,
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Fitness Tracker',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      AnimatedThemeSwitcher(
                        isDarkMode: state.themeMode == ThemeMode.dark,
                        onThemeChanged: (isDarkMode) {
                          context.read<AppCubit>().toggleTheme();
                        },
                        size: 50,
                      ),
                      SizedBox(width: 16.w),
                    ],
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                  ),
                  body: IndexedStack(
                    index: _currentIndex,
                    children: _screens,
                  ),
                  bottomNavigationBar: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, -2),
                        ),
                      ],
                    ),
                    child: NavigationBar(
                      selectedIndex: _currentIndex,
                      onDestinationSelected: _onPageChanged,
                      destinations: [
                        NavigationDestination(
                          icon: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              Icons.fitness_center,
                              color: _currentIndex == 0
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                            ),
                          ),
                          label: 'Exercises',
                        ),
                        NavigationDestination(
                          icon: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: Icon(
                              Icons.trending_up,
                              color: _currentIndex == 1
                                  ? Theme.of(context).colorScheme.primary
                                  : null,
                            ),
                          ),
                          label: 'Progress',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
