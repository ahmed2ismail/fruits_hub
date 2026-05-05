// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:svg_flutter/svg.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.controller,
    this.onChanged,
    this.validator,
    this.hintText,
  });

  final String? labelText;
  final String? hintText;
  final TextInputType keyboardType;
  final bool isPassword;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _isObscured;

  @override
  void initState() {
    super.initState();
    _isObscured = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    // نتحقق إذا كان الحقل مخصص لرقم هاتف أو إيميل لجعله من اليسار لليمين
    final isPhoneOrEmail =
        widget.keyboardType == TextInputType.phone ||
        widget.keyboardType == TextInputType.emailAddress;

    return TextFormField(
      validator: widget.validator,
      onChanged: widget.onChanged,
      controller: widget.controller,
      textAlign: isPhoneOrEmail ? TextAlign.left : TextAlign.right,
      textDirection: isPhoneOrEmail ? TextDirection.ltr : TextDirection.rtl,
      keyboardType: widget.keyboardType,
      obscureText: _isObscured,
      obscuringCharacter: '●',
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.whiteOp,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    _isObscured = !_isObscured;
                  });
                },
                child: _isObscured
                    ? Padding(
                        padding: const EdgeInsetsGeometry.directional(end: 32),
                        child: SvgPicture.asset(
                          AppAssets.eyeAuthPassword,
                          fit: BoxFit.scaleDown,
                          width: 24,
                          height: 24,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsetsGeometry.directional(end: 32),
                        child: const Icon(
                          Icons.visibility_off,
                          color: AppColors.grayscale250,
                          size: 24,
                        ),
                      ),
              )
            : null,
        hintText: widget.hintText,
        hintStyle: widget.hintText != null
            ? TextStyles.bold13.copyWith(color: AppColors.grayscale400)
            : null,
        hintTextDirection: isPhoneOrEmail
            ? TextDirection.ltr
            : TextDirection.rtl,
        labelText: widget.labelText,
        labelStyle: widget.labelText != null
            ? TextStyles.bold13.copyWith(color: AppColors.grayscale400)
            : null,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),

        // شكل الحدود في جميع الحالات (الحالة العادية، عند التمكين، وعند التركيز)
        border: buildBorder(),

        // شكل الحدود في الحالة العادية
        enabledBorder: buildBorder(),

        // شكل الحدود عندما يضغط المستخدم على الحقل للكتابة
        focusedBorder: buildBorder(),
      ),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(4),
      borderSide: const BorderSide(width: 1, color: AppColors.whiteSoft),
    );
  }
}
