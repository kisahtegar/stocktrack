import 'package:get_it/get_it.dart';
import 'package:stocktrack_flutter/core/services/storage_service.dart';
import 'package:stocktrack_flutter/core/utils/http_util.dart';
import 'package:stocktrack_flutter/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:stocktrack_flutter/src/auth/data/repos/auth_repo_impl.dart';
import 'package:stocktrack_flutter/src/auth/domain/repos/auth_repo.dart';
import 'package:stocktrack_flutter/src/auth/domain/usecases/sign_in.dart';
import 'package:stocktrack_flutter/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:stocktrack_flutter/src/supplier/data/datasources/supplier_remote_data_src.dart';
import 'package:stocktrack_flutter/src/supplier/data/repos/supplier_repo_impl.dart';
import 'package:stocktrack_flutter/src/supplier/domain/repos/supplier_repo.dart';
import 'package:stocktrack_flutter/src/supplier/domain/usecases/add_supplier.dart';
import 'package:stocktrack_flutter/src/supplier/domain/usecases/delete_supplier.dart';
import 'package:stocktrack_flutter/src/supplier/domain/usecases/get_detail_supplier.dart';
import 'package:stocktrack_flutter/src/supplier/domain/usecases/get_suppliers.dart';
import 'package:stocktrack_flutter/src/supplier/domain/usecases/update_supplier.dart';
import 'package:stocktrack_flutter/src/supplier/presentation/app/cubit/supplier_cubit.dart';

final sl = GetIt.instance;

/// Initialize the dependency injection container.
Future<void> init() async {
  await _initExternal();
  await _initAuth();
  await _initSupplier();
}

/// Initialize external dependencies.
Future<void> _initExternal() async {
  final storage = await StorageService().init();
  sl
    ..registerLazySingleton(() => storage)
    ..registerLazySingleton(HttpUtil.new); // Register HttpUtil
}

/// Initialize authentication-related dependencies.
Future<void> _initAuth() async {
  sl
    // bloc
    ..registerFactory(() => AuthBloc(signIn: sl()))
    // usecases
    ..registerLazySingleton(() => SignIn(sl()))
    // repositories
    ..registerLazySingleton<AuthRepo>(() => AuthRepoImpl(sl()))
    // datasources
    ..registerLazySingleton<AuthRemoteDataSrc>(
      () => const AuthRemoteDataSrcImpl(),
    );
}

/// Initialize supplier-related dependencies.
Future<void> _initSupplier() async {
  sl
    // cubit
    ..registerFactory(
      () => SupplierCubit(
        addSupplier: sl(),
        deleteSupplier: sl(),
        getDetailSupplier: sl(),
        getSuppliers: sl(),
        updateSupplier: sl(),
      ),
    )
    // usecases
    ..registerLazySingleton(() => AddSupplier(sl()))
    ..registerLazySingleton(() => DeleteSupplier(sl()))
    ..registerLazySingleton(() => GetDetailSupplier(sl()))
    ..registerLazySingleton(() => GetSuppliers(sl()))
    ..registerLazySingleton(() => UpdateSupplier(sl()))
    // repositories
    ..registerLazySingleton<SupplierRepo>(() => SupplierRepoImpl(sl()))
    // datasources
    ..registerLazySingleton<SupplierRemoteDataSrc>(
      SupplierRemoteDataSrcImpl.new,
    );
}
