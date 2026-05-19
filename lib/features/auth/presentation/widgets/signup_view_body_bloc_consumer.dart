import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/helper/functions/custom_snack_bar.dart';
import 'package:fruits_hub/core/widgets/custom_progress_hud_indicator.dart';
import 'package:fruits_hub/features/auth/presentation/manager/cubits/signup_cubit/signup_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/manager/cubits/signup_cubit/signup_state.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/signup_view_body.dart';
import 'package:fruits_hub/generated/l10n.dart';

class SignupViewBodyBlocConsumer extends StatelessWidget {
  const SignupViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          showCustomSnackBar(
            context,
            message: S.of(context).SignupSuccessMessage,
            type: SnackBarType.success,
          );
          // TODO: navigate to home view
        } else if (state is SignupFailure) {
          showCustomSnackBar(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        return CustomProgressHudIndicator(
          isLoading: state is SignupLoading ? true : false,
          child: const SignupViewBody(),
        );
      },
    );
  }
}
