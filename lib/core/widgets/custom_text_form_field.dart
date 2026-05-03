// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_constants.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:svg_flutter/svg.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.labelText,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
  });

  final String labelText;
  final TextInputType keyboardType;
  final bool isPassword;

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
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppConstants.kHorizontalPadding16,
      ),
      child: TextFormField(
        textAlign: TextAlign.right, // لضبط النص ليكون من اليمين
        textDirection: TextDirection.rtl, // لدعم اللغة العربية بشكل سليم
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
                      ? SvgPicture.asset(
                          AppAssets.eyeAuthPassword,
                          fit: BoxFit.scaleDown,
                        )
                      : const Icon(
                          Icons.visibility_off,
                          color: AppColors.grayscale250,
                          size: 24,
                        ),
                )
              : null,
          labelText: widget.labelText,
          labelStyle: TextStyles.bold13.copyWith(color: AppColors.grayscale400),
          // لضبط الارتفاع ليكون تقريباً 56 كما في التصميم
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
