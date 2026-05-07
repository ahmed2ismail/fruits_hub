import 'package:fruits_hub/core/services/firebase_auth_service.dart';
import 'package:fruits_hub/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:fruits_hub/features/auth/domain/repositories/auth_repo.dart';
import 'package:fruits_hub/features/auth/presentation/manager/cubits/signup_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance; // sl = Service Locator

Future<void> init() async {
  // Cubit
  sl.registerFactory(() => SignupCubit(sl<AuthRepo>()));

  // Repository
  sl.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(sl<FirebaseAuthService>()),
  );

  // Services
  sl.registerLazySingleton<FirebaseAuthService>(() => FirebaseAuthService());
}
