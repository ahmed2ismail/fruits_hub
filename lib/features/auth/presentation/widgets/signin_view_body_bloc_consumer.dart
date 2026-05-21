import 'package:flutter/material.dart';
import 'package:fruits_hub/core/helper/functions/custom_snack_bar.dart';
import 'package:fruits_hub/core/widgets/custom_progress_hud_indicator.dart';
import 'package:fruits_hub/features/auth/presentation/manager/cubits/signin_cubit/signin_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/signin_view_body.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/features/home/presentation/view/home_view.dart';
import 'package:fruits_hub/generated/l10n.dart';

class SigninViewBodyBlocConsumer extends StatelessWidget {
  const SigninViewBodyBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state is SigninSuccess) {
          showCustomSnackBar(
            context,
            message: S.of(context).SigninSuccessMessage,
            type: SnackBarType.success,
          );
          // توجيه المستخدم للرئيسية وحذف شاشات التسجيل من الخلفية
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeView.routeName,
            (route) => false,
          );
        } else if (state is SigninFailure) {
          showCustomSnackBar(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
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
