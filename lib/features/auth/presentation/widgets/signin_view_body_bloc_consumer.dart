import 'package:flutter/material.dart';
import 'package:fruits_hub/core/helper/functions/build_error_bar.dart';
import 'package:fruits_hub/core/widgets/custom_progress_hud_indicator.dart';
import 'package:fruits_hub/features/auth/presentation/manager/cubits/signin_cubit/signin_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/signin_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SigninViewBodyBlocConsumer extends StatelessWidget {
  const SigninViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          // TODO: navigate to home view
        } else if (state is SigninFailure) {
          buildErrorBar(context, message: state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHudIndicator(
          isLoading: state is SigninLoading ? true : false,
          child: SigninViewBody(),
        );
      },
    );
  }
}
