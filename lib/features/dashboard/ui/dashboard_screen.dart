import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halan_fitnessapp_task/features/dashboard/ui/widgets/exercise_card.dart';
import 'package:halan_fitnessapp_task/features/dashboard/ui/widgets/exercise_filters.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/exercise_search_bar.dart';
import '../../../core/widgets/loading_widget.dart';
import '../../../core/theming/colors.dart';
import '../../../core/services/page_transitions.dart';
import '../../excercise/ui/excercise_details_screen.dart';
import '../logic/dashboard_cubit.dart';
import '../logic/dashboard_state.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardCubit>()..loadExercises(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SafeArea(
          child: BlocBuilder<DashboardCubit, DashboardState>(
            builder: (context, state) {
              // Only show animations when we have content
              if (state.status == DashboardStatus.success &&
                  state.filteredExercises.isNotEmpty) {
                return _buildDashboardContent(context, state);
              }
              // Show content without animations for loading/error states
              return _buildDashboardContent(context, state);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDashboardContent(BuildContext context, DashboardState state) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(16.w),
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                ColorsManager.primaryColor.withOpacity(0.1),
                ColorsManager.primaryColor.withOpacity(0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: ColorsManager.primaryColor.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Column(
            children: [
              ExerciseSearchBar(
                onSearch: (query) =>
                    context.read<DashboardCubit>().searchExercises(query),
              ),
              SizedBox(height: 20.h),
              ExerciseFilters(
                selectedBodyPart: state.selectedBodyPart,
                selectedEquipment: state.selectedEquipment,
                onBodyPartChanged: (bodyPart) =>
                    context.read<DashboardCubit>().filterByBodyPart(bodyPart),
                onEquipmentChanged: (equipment) =>
                    context.read<DashboardCubit>().filterByEquipment(equipment),
                onClearFilters: () =>
                    context.read<DashboardCubit>().clearFilters(),
              ),
            ],
          ),
        ),
        Expanded(
          child: _buildBody(context, state),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, DashboardState state) {
    switch (state.status) {
      case DashboardStatus.initial:
      case DashboardStatus.loading:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(20.w),
                decoration: BoxDecoration(
                  color: ColorsManager.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.fitness_center,
                  size: 40.sp,
                  color: ColorsManager.secondaryColor,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Loading exercises...',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: ColorsManager.greyColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 50,
                width: 50,
                child: const LoadingWidget(),
              ),
            ],
          ),
        );
      case DashboardStatus.error:
        return CustomErrorWidget(
          message: state.errorMessage ?? 'Something went wrong',
          onRetry: () {
            context.read<DashboardCubit>().loadExercises();
          },
        );
      case DashboardStatus.success:
        if (state.filteredExercises.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                    color: ColorsManager.primaryColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.search_off,
                    size: 40.sp,
                    color: ColorsManager.primaryColor,
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  'No exercises found',
                  style: TextStyle(
                    fontSize: 18.sp,
                    color: ColorsManager.greyColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Try adjusting your search or filters',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: ColorsManager.greyColor.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          itemCount: state.filteredExercises.length,
          itemBuilder: (context, index) {
            final exercise = state.filteredExercises[index];
            return AnimatedContainer(
              duration: Duration(milliseconds: 300 + (index * 50)),
              curve: Curves.easeOutCubic,
              child: Padding(
                padding: EdgeInsets.only(bottom: 16.h),
                child: ExerciseCard(
                  exercise: exercise,
                  onTap: () => _navigateToExerciseDetails(context, exercise.id),
                ),
              ),
            );
          },
        );
    }
  }

  void _navigateToExerciseDetails(BuildContext context, String exerciseId) {
    Navigator.of(context).push(
      PageTransitions.slideFromRightWithFade(
        ExerciseDetailScreen(exerciseId: exerciseId),
      ),
    );
  }
}
