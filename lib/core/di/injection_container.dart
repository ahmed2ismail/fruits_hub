import 'package:fruits_hub/core/services/database_service.dart';
import 'package:fruits_hub/core/services/firebase_auth_service.dart';
import 'package:fruits_hub/core/services/firestore_service.dart';
import 'package:fruits_hub/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:fruits_hub/features/auth/domain/repositories/auth_repo.dart';
import 'package:fruits_hub/features/auth/presentation/manager/cubits/signin_cubit/signin_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/manager/cubits/signup_cubit/signup_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> init() async {
  // لتجنب خطأ (already registered) عند عمل Hot Restart أو Hot Reload
  sl.allowReassignment = true;

  // Cubit
  sl.registerFactory(() => SignupCubit(sl<AuthRepo>()));
  sl.registerFactory(() => SigninCubit(sl<AuthRepo>()));

  // Repository
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(
      sl<FirebaseAuthService>(),
      databaseService: sl<DatabaseService>(),
    ),
  );

  // Services
  sl.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
  sl.registerLazySingleton<DatabaseService>(() => FireStoreService());
}
