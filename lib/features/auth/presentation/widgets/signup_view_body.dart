import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_constants.dart';
import 'package:fruits_hub/core/widgets/custom_default_app_button.dart';
import 'package:fruits_hub/core/widgets/custom_text_form_field.dart';
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

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isButtonEnabled =
        _fullNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _isTermsAccepted;
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
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            const SizedBox(height: 24),
            CustomTextFormField(
              controller: _fullNameController,
              labelText: S.of(context).FullName,
              keyboardType: TextInputType.name,
              onChanged: (value) => setState(() {}),
            ),
            const SizedBox(height: 16),
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
            TermsAndConditionsWidget(
              onStateChanged: (isAccepted) {
                // عند تغيير حالة الشروط، نقوم بتحديث الحالة وإعادة بناء الواجهة
                setState(() {
                  _isTermsAccepted = isAccepted;
                });
              },
            ),
            const SizedBox(height: 30),
            CustomDefaultAppButton(
              text: S.of(context).createNewAccount,
              onPressed: isButtonEnabled
                  ? () {
                      // TODO: navigate to home view
                      // Navigator.pushNamed(context, HomeView.routeName);
                    }
                  : null,
            ),
            const SizedBox(height: 26),
            CustomCheckHaveAccountTextSpan(
              mainText: S.of(context).alreadyHaveAccountText,
              subText: S.of(context).loginText,
              subTextOnTap: () {
                Navigator.pushReplacementNamed(context, LoginView.routeName);
              },
            ),
            // const SizedBox(height: 33),
          ],
        ),
      ),
    );
  }
}
