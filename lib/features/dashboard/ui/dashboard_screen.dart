import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:halan_fitnessapp_task/features/dashboard/ui/widgets/exercise_card.dart';
import 'package:halan_fitnessapp_task/features/dashboard/ui/widgets/exercise_filters.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../core/utilites/dimensions.dart';
import '../../../core/widgets/error_widget.dart';
import '../../../core/widgets/exercise_search_bar.dart';
import '../../../core/widgets/loading_widget.dart';
import '../logic/dashboard_cubit.dart';
import '../logic/dashboard_state.dart';


class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<DashboardCubit>()..loadExercises(),
      child: const DashboardView(),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Exercises')),
      body: SafeArea(
        child: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Column(
                    children: [
                      ExerciseSearchBar(
                        onSearch: (query) => context.read<DashboardCubit>().searchExercises(query),
                      ),
                      SizedBox(height: 16.h),
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
          },
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, DashboardState state) {
    switch (state.status) {
      case DashboardStatus.initial:
      case DashboardStatus.loading:
        return SizedBox(height: 50,width: 50 ,child: const LoadingWidget());
      case DashboardStatus.error:
        return CustomErrorWidget(
          message: state.errorMessage ?? 'Something went wrong',
          onRetry: () => context.read<DashboardCubit>().loadExercises(),
        );
      case DashboardStatus.success:
        if (state.filteredExercises.isEmpty) {
          return const Center(
            child: Text('No exercises found'),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: state.filteredExercises.length,
          itemBuilder: (context, index) {
            final exercise = state.filteredExercises[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ExerciseCard(exercise: exercise),
            );
          },
        );
    }
  }
}
