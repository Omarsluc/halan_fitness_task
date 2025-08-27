import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../../features/app/cubit/app_cubit.dart';
import '../../features/dashboard/data/repo/exercise_repo.dart';
import '../../features/dashboard/data/repo/exercise_repo_impl.dart';
import '../../features/dashboard/logic/dashboard_cubit.dart';
import '../../features/excercise/logic/exercise_details_cubit.dart';
import '../../features/progress/data/repo/workout_repo.dart';
import '../../features/progress/data/repo/workout_repo_impl.dart';
import '../../features/progress/data/repo/progress_repo.dart';
import '../../features/progress/data/repo/progress_repo_impl.dart';
import '../../features/progress/logic/progress_cubit.dart';
import '../api/api_client.dart';
import '../models/exercise_remote_data_model.dart';
import '../services/notifications_service.dart';
import '../services/workout_local_data_storage.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Network
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.options.baseUrl = 'https://exercisedb.p.rapidapi.com';
    dio.options.headers = {
      'X-RapidAPI-Key': 'bc950a5ae2mshe333d574586730cp15402fjsn60e92f06d852',
      'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com',
    };
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      responseHeader: true,
      responseBody: true,
    ));
    return dio;
  });

  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt()));

  getIt.registerLazySingleton<NotificationService>(() => NotificationService());
  // Initialize notifications once during DI setup
  await getIt<NotificationService>().initialize();

  getIt.registerLazySingleton<ExerciseRemoteDataSource>(
    () => ExerciseRemoteDataSource(getIt()),
  );

  getIt.registerLazySingleton<WorkoutLocalDataSource>(
    () => WorkoutLocalDataSource(),
  );

  getIt.registerLazySingleton<ExerciseRepository>(
    () => ExerciseRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<WorkoutRepository>(
    () => WorkoutRepositoryImpl(getIt()),
  );

  getIt.registerLazySingleton<ProgressRepository>(
    () => ProgressRepositoryImpl(),
  );

  // Cubits
  getIt.registerLazySingleton<AppCubit>(() => AppCubit());
  getIt.registerFactory<ExerciseDetailCubit>(
      () => ExerciseDetailCubit(getIt(), getIt(), getIt()));
  getIt.registerFactory<DashboardCubit>(() => DashboardCubit(getIt()));
  getIt.registerFactory<ProgressCubit>(() => ProgressCubit(getIt()));
}
