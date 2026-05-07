import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruits_hub/core/helper/functions/get_current_local.dart';
import 'package:fruits_hub/core/utils/app_constants.dart';
import 'package:fruits_hub/core/widgets/custom_default_app_button.dart';
import 'package:fruits_hub/core/widgets/custom_text_form_field.dart';
import 'package:fruits_hub/features/auth/presentation/manager/cubits/signup_cubit.dart';
import 'package:fruits_hub/features/auth/presentation/view/login_view.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/custom_check_have_account_text_span.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/terms_and_conditions_widget.dart';
import 'package:fruits_hub/generated/l10n.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isTermsAccepted = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late AutovalidateMode _autoValidateMode = AutovalidateMode.disabled;
  late final ValueNotifier<bool> _isButtonEnabledNotifier;

  @override
  void initState() {
    super.initState();
    _isButtonEnabledNotifier = ValueNotifier<bool>(false);
    _fullNameController.addListener(_updateButtonState);
    _emailController.addListener(_updateButtonState);
    _passwordController.addListener(_updateButtonState);
  }

  @override
  void dispose() {
    _fullNameController.removeListener(_updateButtonState);
    _emailController.removeListener(_updateButtonState);
    _passwordController.removeListener(_updateButtonState);
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _isButtonEnabledNotifier.dispose();
    super.dispose();
  }

  void _updateButtonState() {
    _isButtonEnabledNotifier.value =
        _fullNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _isTermsAccepted;
  }

  @override
  Widget build(BuildContext context) {
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
        autovalidateMode: _autoValidateMode,
        child: Column(
          children: [
            const SizedBox(height: 24),
            CustomTextFormField(
              controller: _fullNameController,
              labelText: S.of(context).FullName,
              keyboardType: TextInputType.name,
              onSaved: (value) {},
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return isEnglish()
                      ? 'Please enter your full name'
                      : "الرجاء إدخال الاسم الكامل.";
                } else if (value.length < 3) {
                  return isEnglish()
                      ? 'Full name must be at least 3 characters'
                      : 'الاسم الكامل يجب الا يقل عن 3 أحرف.';
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _emailController,
              labelText: S.of(context).emailTextFieldLabel,
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) {},
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
              onSaved: (value) {},
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
            TermsAndConditionsWidget(
              onStateChanged: (isAccepted) {
                // عند تغيير حالة الشروط، نقوم بتحديث الحالة وإعادة بناء الواجهة
                setState(() {
                  _isTermsAccepted = isAccepted;
                  _updateButtonState();
                });
              },
            ),
            const SizedBox(height: 30),
            ValueListenableBuilder<bool>(
              valueListenable: _isButtonEnabledNotifier,
              builder: (context, isEnabled, child) {
                return CustomDefaultAppButton(
                  text: S.of(context).createNewAccount,
                  onPressed: isEnabled
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            context
                                .read<SignupCubit>()
                                .createUserWithEmailAndPassword(
                                  _emailController.text,
                                  _passwordController.text,
                                  _fullNameController.text,
                                );
                          } else {
                            setState(() {
                              _autoValidateMode = AutovalidateMode.always;
                            });
                          }
                          // TODO: navigate to home view
                          // Navigator.pushNamed(context, HomeView.routeName);
                        }
                      : null,
                );
              },
            ),
            const SizedBox(height: 26),
            CustomCheckHaveAccountTextSpan(
              mainText: S.of(context).alreadyHaveAccountText,
              subText: S.of(context).loginText,
              subTextOnTap: () {
                Navigator.pushReplacementNamed(context, LoginView.routeName);
              },
            ),
          ],
        ),
      ),
    );
  }
}
