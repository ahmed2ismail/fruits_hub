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
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _isTermsAccepted = false;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();

    _fullNameController.addListener(_validateFields);
    _emailController.addListener(_validateFields);
    _passwordController.addListener(_validateFields);
  }

  @override
  void dispose() {
    _fullNameController.removeListener(_validateFields);
    _emailController.removeListener(_validateFields);
    _passwordController.removeListener(_validateFields);
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateFields() {
    final isButtonEnabled =
        _fullNameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _isTermsAccepted;
    if (isButtonEnabled != _isButtonEnabled) {
      setState(() {
        _isButtonEnabled = isButtonEnabled;
      });
    }
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
      child: Column(
        children: [
          const SizedBox(height: 24),
          CustomTextFormField(
            controller: _fullNameController,
            labelText: S.of(context).FullName,
            keyboardType: TextInputType.name,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: _emailController,
            labelText: S.of(context).emailTextFieldLabel,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 16),
          CustomTextFormField(
            controller: _passwordController,
            labelText: S.of(context).passwordTextFieldLabel,
            keyboardType: TextInputType.visiblePassword,
            isPassword: true,
          ),
          const SizedBox(height: 16),
          TermsAndConditionsWidget(
            onStateChanged: (isAccepted) {
              _isTermsAccepted = isAccepted;
              _validateFields();
            },
          ),
          const SizedBox(height: 30),
          CustomDefaultAppButton(
            text: S.of(context).createNewAccount,
            onPressed: _isButtonEnabled
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
    );
  }
}
