import 'package:get_it/get_it.dart';
import 'package:stocktrack_flutter/core/services/storage_service.dart';
import 'package:stocktrack_flutter/core/utils/http_util.dart';
import 'package:stocktrack_flutter/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:stocktrack_flutter/src/auth/data/repos/auth_repo_impl.dart';
import 'package:stocktrack_flutter/src/auth/domain/repos/auth_repo.dart';
import 'package:stocktrack_flutter/src/auth/domain/usecases/sign_in.dart';
import 'package:stocktrack_flutter/src/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initExternal();
  await _initAuth();
}

Future<void> _initExternal() async {
  final storage = await StorageService().init();
  sl
    ..registerLazySingleton(() => storage)
    ..registerLazySingleton(HttpUtil.new); // Register HttpUtil
}

Future<void> _initAuth() async {
  sl
    ..registerFactory(() => AuthBloc(signIn: sl()))
    ..registerLazySingleton(() => SignIn(sl()))
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    ..registerLazySingleton<AuthRemoteDataSrc>(
      () => const AuthRemoteDataSrcImpl(),
    );
}
