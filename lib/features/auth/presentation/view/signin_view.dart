import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/di/injection_container.dart' as di;
import 'package:fruits_hub/core/widgets/custom_app_bar.dart';
import 'package:fruits_hub/features/auth/presentation/manager/cubits/signin_cubit/signin_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/signin_view_body_bloc_consumer.dart';
import 'package:fruits_hub/generated/l10n.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  static const String routeName = 'signin_view';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<SigninCubit>(),
      child: Scaffold(
        resizeToAvoidBottomInset:
            false, // عشان لما يطلع الكيبورد مايحصلش overflow لل height يعني الشاشة متغيرش نفسها
        appBar: CustomAppBar(title: S.of(context).loginAppBarTitle),
        body: SafeArea(child: SigninViewBodyBlocConsumer()),
      ),
    );
  }
}
