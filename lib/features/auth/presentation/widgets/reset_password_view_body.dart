import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_constants.dart';
import 'package:fruits_hub/core/widgets/custom_default_app_button.dart';
import 'package:fruits_hub/core/widgets/custom_text_form_field.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/auth_user_helper_message.dart';
import 'package:fruits_hub/generated/l10n.dart';
import 'package:fruits_hub/core/widgets/custom_success_dialog.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/features/auth/presentation/view/login_view.dart';

class ResetPasswordViewBody extends StatefulWidget {
  const ResetPasswordViewBody({super.key});

  @override
  State<ResetPasswordViewBody> createState() => _ResetPasswordViewBodyState();
}

class _ResetPasswordViewBodyState extends State<ResetPasswordViewBody> {
  late final TextEditingController _passwordController =
      TextEditingController();
  late final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled =
        _passwordController.text.length >= 8 &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty &&
        _passwordController.text == _confirmPasswordController.text;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        left: AppConstants.kHorizontalPadding16,
        right: AppConstants.kHorizontalPadding16,
        // السطر ده سحري: بيخلي الشاشة تترفع لفوق بمقدار ارتفاع الكيبورد لما يفتح، عشان الكيبورد ميغطيش على الزرار
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          AuthUserHelperMessage(
            text: S.of(context).ResetYourPasswordHelperMessage,
            color: AppColors.grayscale950,
          ),
          const SizedBox(height: 34),
          CustomTextFormField(
            controller: _passwordController,
            labelText: S.of(context).NewPassword,
            keyboardType: TextInputType.visiblePassword,
            isPassword: true,
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 24),
          CustomTextFormField(
            controller: _confirmPasswordController,
            labelText: S.of(context).ConfirmPassword,
            keyboardType: TextInputType.visiblePassword,
            isPassword: true,
            onChanged: (value) => setState(() {}),
          ),
          const SizedBox(height: 24),
          CustomDefaultAppButton(
            text: S.of(context).CreateNewPasswordTextButton,
            onPressed: isButtonEnabled
                ? () {
                    // 1. السطر ده بيقفل الكيبورد أول ما يضغط على الزرار عشان الـ Dialog يظهر في النص بالظبط
                    FocusScope.of(context).unfocus();

                    // 2. إظهار الـ Dialog
                    showDialog(
                      context: context,
                      // barrierDismissible: false بتمنع المستخدم إنه يقفل الـ Dialog لو ضغط في أي مكان بره
                      barrierDismissible: false,
                      builder: (context) {
                        return CustomSuccessDialog(
                          message: S.of(context).SuccefulChangedPasswordMessage,
                          iconPath: AppAssets.successCheckIcon,
                        );
                      },
                    );
                    Future.delayed(const Duration(seconds: 2), () {
                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          LoginView.routeName,
                          (route) => false,
                        );
                      }
                    });
                  }
                : null,
          ),
        ],
      ),
    );
  }
}
