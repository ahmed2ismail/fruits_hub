import 'package:flutter/material.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/custom_check_have_account_text_span.dart';
import 'package:fruits_hub/core/widgets/custom_default_app_button.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/custom_forget_password_text_button.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/custom_or_divider.dart';
import 'package:fruits_hub/core/widgets/custom_text_Form_field.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/social_login_section.dart';
import 'package:fruits_hub/generated/l10n.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        // عشان لما يطلع الكيبورد مايحصلش overflow لل height يعني الشاشة متغيرش نفسها
        // viewInsets.bottom بترجع المساحة اللي اتاخدت من الشاشة بسبب الكيبورد
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        children: [
          const SizedBox(height: 24),
          CustomTextFormField(
            labelText: S.of(context).emailTextFieldLabel,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            labelText: S.of(context).passwordTextFieldLabel,
            keyboardType: TextInputType.visiblePassword,
            isPassword: true,
          ),
          const SizedBox(height: 16),
          CustomForgetPasswordTextButton(
            onPressed: () {
              // TODO: navigate to forget password view
              // Navigator.pushNamed(context, ForgetPasswordView.routeName);
            },
          ),
          const SizedBox(height: 33),
          CustomDefaultAppButton(
            onPressed: () {
              // TODO: navigate to home view
              // Navigator.pushNamed(context, HomeView.routeName);
            },
          ),
          const SizedBox(height: 33),
          CustomCheckHaveAccountTextSpan(
            mainText: S.of(context).dontHaveAccountText,
            subText: S.of(context).registerText,
            subTextOnTap: () {
              // TODO: navigate to register view
              // Navigator.pushNamed(context, RegisterView.routeName);
            },
          ),
          const SizedBox(height: 33),
          const CustomOrDivider(),
          const SizedBox(height: 16),

          // تم استخراج أزرار السوشيال ميديا في ويدجت منفصلة لتنظيف الكود
          const SocialLoginSection(),
        ],
      ),
    );
  }
}
