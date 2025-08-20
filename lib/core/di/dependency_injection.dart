import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../../features/app/cubit/app_cubit.dart';
import '../../features/dashboard/logic/dashboard_cubit.dart';
import '../api/api_client.dart';
import '../models/exercise_remote_data_model.dart';
import '../services/notifications_service.dart';


final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // Network
  getIt.registerLazySingleton<Dio>(() {
    final dio = Dio();
    dio.options.baseUrl = 'https://exercisedb.p.rapidapi.com';
    dio.options.headers = {
      'X-RapidAPI-Key': '',
      'X-RapidAPI-Host': 'exercisedb.p.rapidapi.com',
    };
    dio.interceptors.add(LogInterceptor());
    return dio;
  });

  getIt.registerLazySingleton<ApiClient>(() => ApiClient(getIt()));

  getIt.registerLazySingleton<NotificationService>(() => NotificationService());

  getIt.registerLazySingleton<ExerciseRemoteDataSource>(
        () => ExerciseRemoteDataSource(getIt()),
  );

  // Cubits
  getIt.registerLazySingleton<AppCubit>(() => AppCubit());

}