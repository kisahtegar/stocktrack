import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stocktrack_flutter/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:stocktrack_flutter/src/auth/data/repos/auth_repo_impl.dart';
import 'package:stocktrack_flutter/src/auth/domain/repos/auth_repo.dart';
import 'package:stocktrack_flutter/src/auth/domain/usecases/sign_in.dart';
import 'package:stocktrack_flutter/src/auth/presentation/cubit/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initAuth();
}

Future<void> _initAuth() async {
  final prefs = await SharedPreferences.getInstance();

  sl
    ..registerFactory(() => AuthCubit(signIn: sl()))
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSrc>(
      () => AuthRemoteDataSrcImpl(
        client: sl(),
        sharedPreferences: sl(),
      ),
    )
    ..registerLazySingleton(() => prefs)
    ..registerLazySingleton(http.Client.new);
}
