import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_constants.dart';
import 'package:fruits_hub/features/auth/presentation/view/forgot_password_view.dart';
import 'package:fruits_hub/features/auth/presentation/view/signup_view.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/custom_check_have_account_text_span.dart';
import 'package:fruits_hub/core/widgets/custom_default_app_button.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/custom_forget_password_text_button.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/custom_or_divider.dart';
import 'package:fruits_hub/core/widgets/custom_text_Form_field.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/social_login_section.dart';
import 'package:fruits_hub/generated/l10n.dart';

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // يتم حساب هذه القيمة مع كل إعادة بناء للويدجت
    final isButtonEnabled =
        _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        left: AppConstants.kHorizontalPadding16,
        right: AppConstants.kHorizontalPadding16,
        // عشان لما يطلع الكيبورد مايحصلش overflow لل height يعني الشاشة متغيرش نفسها
        // viewInsets.bottom بترجع المساحة اللي اتاخدت من الشاشة بسبب الكيبورد
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        // هذا السطر يجعل الـ Form يعيد بناء نفسه مع كل تغيير من المستخدم
        // مما يسمح لنا بتحديث حالة الزر بشكل تفاعلي
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const SizedBox(height: 24),
            CustomTextFormField(
              controller: _emailController,
              labelText: S.of(context).emailTextFieldLabel,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _passwordController,
              labelText: S.of(context).passwordTextFieldLabel,
              keyboardType: TextInputType.visiblePassword,
              isPassword: true,
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 16),
            CustomForgetPasswordAndRecoveryTextButton(
              onPressed: () {
                Navigator.pushNamed(context, ForgotPasswordView.routeName);
              },
            ),
            const SizedBox(height: 33),
            CustomDefaultAppButton(
              onPressed: isButtonEnabled
                  ? () {
                      // TODO: navigate to home view
                      // Navigator.pushNamed(context, HomeView.routeName);
                    }
                  : null,
            ),
            const SizedBox(height: 33),
            CustomCheckHaveAccountTextSpan(
              mainText: S.of(context).dontHaveAccountText,
              subText: S.of(context).registerText,
              subTextOnTap: () {
                Navigator.pushReplacementNamed(context, SignupView.routeName);
              },
            ),
            const SizedBox(height: 33),
            const CustomOrDivider(),
            const SizedBox(height: 16),

            // تم استخراج أزرار السوشيال ميديا في ويدجت منفصلة لتنظيف الكود
            const SocialLoginSection(),
          ],
        ),
      ),
    );
  }
}
