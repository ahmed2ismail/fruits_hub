import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/custom_check_have_account_text_span.dart';
import 'package:fruits_hub/generated/l10n.dart';

class TermsAndConditionsWidget extends StatefulWidget {
  const TermsAndConditionsWidget({super.key, this.onStateChanged});

  final void Function(bool)? onStateChanged;

  @override
  State<TermsAndConditionsWidget> createState() =>
      _TermsAndConditionsWidgetState();
}

class _TermsAndConditionsWidgetState extends State<TermsAndConditionsWidget> {
  bool isTermsAccepted = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start, // لمحاذاة المربع مع بداية النص لو كان سطرين
      children: [
        // المربع القابل للضغط
        GestureDetector(
          onTap: () {
            setState(() {
              isTermsAccepted = !isTermsAccepted;
              if (widget.onStateChanged != null) {
                widget.onStateChanged!(isTermsAccepted);
              }
            });
          },
          child: AnimatedContainer(
            duration: const Duration(
              milliseconds: 200,
            ), // أنيميشن ناعم لتغير اللون
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              // تغيير لون الخلفية بناءً على الحالة
              color: isTermsAccepted
                  ? AppColors.green1_500
                  : AppColors.backgroundWhiteColor,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                // تغيير لون الحدود بناءً على الحالة
                color: isTermsAccepted
                    ? AppColors.green1_500
                    : AppColors.whiteShift,
                width: 1.5,
              ),
            ),
            // إظهار علامة الصح فقط إذا تم التحديد
            child: isTermsAccepted
                ? const Icon(
                    Icons.check,
                    color: AppColors.backgroundWhiteColor,
                    size: 16,
                  )
                : const SizedBox(),
          ),
        ),

        const SizedBox(width: 16), // المسافة بين المربع والنص
        // استخدام Expanded لكي يأخذ النص باقي المساحة ولا يحدث Overflow
        Expanded(
          child: CustomCheckHaveAccountTextSpan(
            textAlign: TextAlign.start,
            mainText: S.of(context).byCreatingAnAccountYouAgree,
            subText: S.of(context).toOurTermsAndConditions,
            subTextOnTap: () {
              //TODO: مسار الانتقال لصفحة قراءة الشروط والأحكام
            },
          ),
        ),
      ],
    );
  }
}
