import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/helper/functions/build_error_bar.dart';
import 'package:fruits_hub/features/auth/presentation/manager/cubits/signup_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/manager/cubits/signup_cubit/signup_state.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/signup_view_body.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          // Navigator.pop(context);
        } else if (state is SignupFailure) {
          buildErrorBar(context, message: state.message);
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is SignupLoading ? true : false,
          child: const SignupViewBody(),
        );
      },
    );
  }
}
