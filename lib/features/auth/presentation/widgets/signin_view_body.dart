import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/helper/functions/get_current_local.dart';
import 'package:fruits_hub/core/utils/app_constants.dart';
import 'package:fruits_hub/features/auth/presentation/manager/cubits/signin_cubit/signin_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/view/forgot_password_view.dart';
import 'package:fruits_hub/features/auth/presentation/view/signup_view.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/custom_check_have_account_text_span.dart';
import 'package:fruits_hub/core/widgets/custom_default_app_button.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/custom_forget_password_text_button.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/custom_or_divider.dart';
import 'package:fruits_hub/core/widgets/custom_text_Form_field.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/social_login_section.dart';
import 'package:fruits_hub/generated/l10n.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  bool get valid => _formKey.currentState?.validate() ?? false;

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
        key: _formKey,
        // هذا السطر يجعل الـ Form يعيد بناء نفسه مع كل تغيير من المستخدم
        // مما يسمح لنا بتحديث حالة الزر بشكل تفاعلي
        // autovalidateMode: AutovalidateMode.onUserInteraction,
        autovalidateMode: _autoValidateMode,
        child: Column(
          children: [
            const SizedBox(height: 24),
            CustomTextFormField(
              controller: _emailController,
              labelText: S.of(context).emailTextFieldLabel,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) => setState(() {}),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return isEnglish()
                      ? 'Please enter your email'
                      : 'الرجاء إدخال البريد الإلكتروني.';
                } else if (!value.contains('@')) {
                  return isEnglish()
                      ? 'Please enter a valid email'
                      : 'الرجاء إدخال بريد إلكتروني صالح.';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _passwordController,
              labelText: S.of(context).passwordTextFieldLabel,
              keyboardType: TextInputType.visiblePassword,
              isPassword: true,
              onChanged: (value) => setState(() {}),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return isEnglish()
                      ? 'Please enter your password'
                      : 'الرجاء إدخال كلمة المرور.';
                } else if (value.length < 8) {
                  return isEnglish()
                      ? 'Password must be at least 8 characters'
                      : 'كلمة المرور يجب ألا تقل عن 8 أحرف.';
                } else {
                  return null;
                }
              },
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
                      if (valid) {
                        context.read<SigninCubit>().signInWithEmailAndPassword(_emailController.text, _passwordController.text);
                      } else {
                        setState(() {
                          // دا عشان يظهر رسائل الخطأ فوراً إذا كانت البيانات غير صالحة
                          _autoValidateMode = AutovalidateMode.always;
                        });
                      }
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
                Navigator.pushNamed(context, SignupView.routeName);
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
