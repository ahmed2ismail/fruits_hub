import 'package:flutter/material.dart';
import 'package:fruits_hub/core/widgets/custom_app_bar.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/forgot_password_view_body.dart';
import 'package:fruits_hub/generated/l10n.dart';

class ForgotPasswordView extends StatelessWidget {
  const ForgotPasswordView({super.key});

  static const String routeName = 'forgot_password_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // عشان لما يطلع الكيبورد مايحصلش overflow لل height يعني الشاشة متغيرش نفسها
      appBar: CustomAppBar(title: S.of(context).ForgotPasswordAppBarTitle),
      body: SafeArea(child: ForgotPasswordViewBody()),
    );
  }
}
