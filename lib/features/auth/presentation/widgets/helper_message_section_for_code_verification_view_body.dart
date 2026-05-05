import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/auth_user_helper_message.dart';
import 'package:fruits_hub/generated/l10n.dart';

class HelperMessageSectionForCodeVerificationViewBody extends StatelessWidget {
  const HelperMessageSectionForCodeVerificationViewBody({
    super.key,
    this.emailReceivedTheCode,
  });

  final String? emailReceivedTheCode;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 24),
        // رسالة المساعدة
        AuthUserHelperMessage(
          text: S.of(context).CodeVerificationHelperMessage,
        ),

        // الإيميل اللي اتبعتله الكود
        const SizedBox(height: 8),

        SizedBox(
          width: double.infinity,
          child: Text(
            emailReceivedTheCode ?? 'Maxxx@email.com',
            textAlign: TextAlign.right,
            // استخدام LTR مهم عشان الإيميل يظهر بشكل سليم من غير لخبطة
            textDirection: TextDirection.ltr,
            style: TextStyles.semiBold16.copyWith(
              color: AppColors.grayscale600,
            ),
          ),
        ),
        const SizedBox(height: 31),
      ],
    );
  }
}
