import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/di/injection_container.dart' as di;
import 'package:fruits_hub/core/widgets/custom_app_bar.dart';
import 'package:fruits_hub/features/auth/presentation/manager/cubits/signup_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/signup_view_body_bloc_consumer.dart';
import 'package:fruits_hub/generated/l10n.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const String routeName = 'signup_view';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<SignupCubit>(),
      child: Scaffold(
        resizeToAvoidBottomInset:
            false, // عشان لما يطلع الكيبورد مايحصلش overflow لل height يعني الشاشة متغيرش نفسها
        appBar: CustomAppBar(title: S.of(context).newAccount),
        body: SafeArea(child: const SignupViewBodyBlocConsumer()),
      ),
    );
  }
}
