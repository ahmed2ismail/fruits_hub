import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_images.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/generated/l10n.dart';
import 'package:svg_flutter/svg.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    this.labelText,
    this.keyboardType = TextInputType.text,
    this.controller,
    this.onChanged,
    this.hintText,
  });

  final String? labelText;
  final String? hintText;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    // نتحقق إذا كان الحقل مخصص لرقم هاتف أو إيميل لجعله من اليسار لليمين
    final isPhoneOrEmail =
        keyboardType == TextInputType.phone ||
        keyboardType == TextInputType.emailAddress;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 9,
            offset: Offset(0, 2),
            spreadRadius: 0,
          ),
        ],
      ),
      child: TextFormField(
        onChanged: onChanged,
        controller: controller,
        textAlign: isPhoneOrEmail
            ? TextAlign.left
            : TextAlign.start, // Use TextAlign.start for natural alignment
        textDirection: isPhoneOrEmail
            ? TextDirection.ltr
            : null, // Let Flutter decide for other fields
        keyboardType: keyboardType,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          hintText: hintText ?? S.of(context).searchAbout,
          hintStyle: TextStyles.regular13.copyWith(
            color: AppColors.grayscale400,
            height: 1.60,
          ),
          labelText: labelText,
          labelStyle: TextStyles.regular13.copyWith(
            color: AppColors.grayscale400,
            height: 1.60,
          ),
          prefixIcon: SvgPicture.asset(
            AppAssets.imagesSearchIcon,
            fit: BoxFit.scaleDown,
            height: 20,
            width: 20,
          ),
          suffixIcon: SvgPicture.asset(
            AppAssets.imagesFilter,
            fit: BoxFit.scaleDown,
            height: 20,
            width: 20,
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
      borderSide: const BorderSide(width: 1, color: Colors.white),
    );
  }
}
