import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:pin_code_fields/pin_code_fields.dart'; // باكدج المربعات الخاصة بالـ OTP
import 'package:fruits_hub/core/utils/app_colors.dart';

// الويدجت المستخرجة: مسؤولة فقط عن رسم مربعات إدخال الكود (OTP)
class CustomPinCodeField extends StatelessWidget {
  const CustomPinCodeField({super.key, required this.onChanged, this.pinController});

  // متغير لاستقبال الدالة اللي هتتنفذ لما المستخدم يكتب رقم
  final void Function(String) onChanged;
  final PinInputController? pinController;
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: MaterialPinField(
        pinController: pinController,
        // عدد المربعات اللي هتظهر للمستخدم
        length: 4, 
        // عشان نفتح لوحة مفاتيح الأرقام بس للمستخدم (مش الحروف)
        keyboardType: TextInputType.number, 
        onChanged: onChanged,

        theme: MaterialPinTheme(
          shape: MaterialPinShape.outlined, 
          cellSize: const Size(74, 60), 
          borderRadius: BorderRadius.circular(8),
          cursorColor: AppColors.green1_500,

          // --- ألوان خلفية المربع (من جوه) ---
          fillColor: AppColors.whiteOp, // لونه وهو فاضي
          focusedFillColor: AppColors.backgroundWhiteColor, // لونه والمستخدم واقف بيكتب جواه
          filledFillColor: AppColors.backgroundWhiteColor, // لونه بعد ما المستخدم يكتب الرقم ويسيبه
          
          // --- ألوان إطار أو حدود المربع (من بره) ---
          borderColor: AppColors.whiteSoft, // لون الإطار والمربع فاضي
          focusedBorderColor: AppColors.orange500, // لون الإطار والمستخدم بيكتب
          filledBorderColor: AppColors.whiteSoft, // لون الإطار بعد ما يخلص كتابة في المربع
          textStyle: TextStyles.bold23.copyWith(
            color: AppColors.grayscale950,
            height: 1.40,
          ),
        ),
      ),
    );
  }
}