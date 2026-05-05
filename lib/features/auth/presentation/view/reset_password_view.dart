import 'package:flutter/material.dart';
import 'package:fruits_hub/core/widgets/custom_app_bar.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/reset_password_view_body.dart';
import 'package:fruits_hub/generated/l10n.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  static const routeName = 'reset_password_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: S.of(context).ResetYourPasswordAppBarTitle),
      body: SafeArea(child: ResetPasswordViewBody()),
    );
  }
}
