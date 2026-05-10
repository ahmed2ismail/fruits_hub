import 'package:fruits_hub/features/auth/domain/repositories/auth_repo.dart';
import 'package:fruits_hub/features/auth/presentation/manager/cubits/signup_cubit/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
    String name,
  ) async {
    emit(SignupLoading());
    final result = await authRepo.createUserWithEmailAndPassword(
      email,
      password,
      name,
    );
    result.fold(
      (failure) => emit(SignupFailure(message: failure.errMessage)),
      (userEntity) => emit(SignupSuccess(userEntity: userEntity)),
    );
  }
}
