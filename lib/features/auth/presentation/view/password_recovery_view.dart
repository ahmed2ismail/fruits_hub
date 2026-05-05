import 'package:flutter/material.dart';
import 'package:fruits_hub/core/widgets/custom_app_bar.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/password_recovery_view_body.dart';
import 'package:fruits_hub/generated/l10n.dart';

class PasswordRecoveryView extends StatelessWidget {
  const PasswordRecoveryView({super.key});

  static const String routeName = 'password_recovery_view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(title: S.of(context).CodeVerificationAppBarTitle),
      body: SafeArea(child: PasswordRecoveryViewBody()),
    );
  }
}
