import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_constants.dart';
import 'package:fruits_hub/core/widgets/custom_default_app_button.dart';
import 'package:fruits_hub/core/widgets/custom_text_form_field.dart';
import 'package:fruits_hub/features/auth/presentation/view/password_recovery_view.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/auth_user_helper_message.dart';
import 'package:fruits_hub/generated/l10n.dart';

class ForgotPasswordViewBody extends StatefulWidget {
  const ForgotPasswordViewBody({super.key});

  @override
  State<ForgotPasswordViewBody> createState() => _ForgotPasswordViewBodyState();
}

class _ForgotPasswordViewBodyState extends State<ForgotPasswordViewBody> {
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  void dispose() {
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // يتم حساب هذه القيمة مع كل إعادة بناء للويدجت
    final isButtonEnabled = _phoneNumberController.text.isNotEmpty;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        left: AppConstants.kHorizontalPadding16,
        right: AppConstants.kHorizontalPadding16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const SizedBox(height: 24),
            AuthUserHelperMessage(
              text: S.of(context).ForgotPasswordHelperMessage,
            ),
            const SizedBox(height: 31),
            CustomTextFormField(
              hintText: '+20 123 567 8911',
              labelText: S.of(context).phoneNumberWithCountryCode,
              keyboardType: TextInputType.phone,
              controller: _phoneNumberController,
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 30),
            CustomDefaultAppButton(
              text: S.of(context).IForgotMyPassword,
              onPressed: isButtonEnabled
                  ? () {
                      Navigator.pushNamed(
                        context,
                        PasswordRecoveryView.routeName,
                      );
                    }
                  : null,
            ),
            const SizedBox(height: 33),
          ],
        ),
      ),
    );
  }
}
