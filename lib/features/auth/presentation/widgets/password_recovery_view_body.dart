import 'dart:async'; // مكتبة خاصة بالوقت عشان نستخدم منها الـ Timer (العداد)
import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/app_colors.dart';
import 'package:fruits_hub/core/utils/app_constants.dart';
import 'package:fruits_hub/core/utils/app_text_styles.dart';
import 'package:fruits_hub/core/widgets/custom_default_app_button.dart';
import 'package:fruits_hub/features/auth/presentation/view/reset_password_view.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/custom_forget_password_text_button.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/custom_pin_code_field.dart';
import 'package:fruits_hub/features/auth/presentation/widgets/helper_message_section_for_code_verification_view_body.dart';
import 'package:fruits_hub/generated/l10n.dart';
import 'package:pin_code_fields/pin_code_fields.dart'; // مكتبة الترجمة لدعم اللغات

class PasswordRecoveryViewBody extends StatefulWidget {
  const PasswordRecoveryViewBody({super.key});

  @override
  State<PasswordRecoveryViewBody> createState() =>
      _PasswordRecoveryViewBodyState();
}

class _PasswordRecoveryViewBodyState extends State<PasswordRecoveryViewBody> {
  // 1. المتغيرات (Variables) الخاصة بالشاشة
  // المتغير ده بيحفظ الأرقام اللي المستخدم بيكتبها جوه المربعات
  String currentCode = "";
  // ده العداد بتاعنا اللي هيحسب الوقت التنازلي (60، 59، 58...)
  Timer? _timer;
  // الوقت اللي هيبدأ منه العداد (60 ثانية)
  int _start = 60;
  // متغير بيحدد هل زرار "إعادة إرسال الرمز" شغال وممكن نضغط عليه ولا مقفول؟
  bool _isResendButtonEnabled = true;
  final PinInputController _pinController = PinInputController();

  // 2. الدوال (Methods) الخاصة بالمنطق (Logic)
  // الدالة دي بتشتغل لما المستخدم يضغط على "إعادة إرسال الرمز"
  void startTimer() {
    setState(() {
      // أول حاجة بنقفل الزرار عشان المستخدم ميضغطش عليه تاني والعداد شغال
      _isResendButtonEnabled = false;
    });

    // بنحدد إن العداد هينقص كل ثانية واحدة
    const oneSec = Duration(seconds: 1);

    // بنشغل العداد
    _timer = Timer.periodic(oneSec, (Timer timer) {
      // لو العداد وصل لـ صفر
      if (_start == 0) {
        setState(() {
          timer.cancel(); // بنوقف العداد
          // بنرجع نفتح الزرار تاني عشان لو حابب يبعت كود جديد
          _isResendButtonEnabled = true;
          _start = 60; // بنرستر الوقت لـ 60 ثانية عشان المرة الجاية
        });
      } else {
        // لو العداد لسه موصلش لصفر، بننقص ثانية ونعمل تحديث للشاشة
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    // دالة الـ dispose بتشتغل لما نخرج من الشاشة دي خالص
    // لازم نوقف فيها العداد عشان ميفضلش شغال في الخلفية ويسحب من رامات الموبايل (Memory Leak)
    _timer?.cancel();
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // اللوجيك ده بيتحقق: هل المستخدم كتب 4 أرقام؟
    // لو آه هيرجع true والزرار الأساسي هيتفعل. لو لسه هيفضل false والزرار مقفول.
    final isButtonEnabled = currentCode.length == 4;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        left: AppConstants.kHorizontalPadding16,
        right: AppConstants.kHorizontalPadding16,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            // ويدجت الرسالة اللي فوق (أدخل الرمز الذي أرسلناه...)
            const HelperMessageSectionForCodeVerificationViewBody(),
            const SizedBox(height: 31),
            // ويدجت مربعات إدخال الكود (OTP)
            CustomPinCodeField(
              pinController: _pinController,
              // الدالة دي بتشتغل في كل مرة المستخدم بيكتب رقم جديد جوه المربع أو يمسح رقم
              onChanged: (value) {
                setState(() {
                  // بنحدث المتغير بتاعنا بالقيمة الجديدة عشان نفعل الزرار لو بقوا 4 أرقام
                  currentCode = value;
                });
              },
            ),

            const SizedBox(height: 30),

            // الزرار الأساسي (تحقق من الرمز)
            CustomDefaultAppButton(
              text: S.of(context).CodeVerificationTextButton,
              // لو isButtonEnabled قيمته true هنشغل الزرار وننقله للشاشة الجاية
              // لو قيمته false هندي للـ onPressed قيمة null (وده بيخلي شكل الزرار باهت وميضغطش في فلاتر)
              onPressed: isButtonEnabled
                  ? () {
                      Navigator.pushNamed(context, ResetPasswordView.routeName);
                      // print("الكود المدخل هو: $currentCode");
                      _pinController.clear();
                      currentCode = "";
                    }
                  : null,
            ),

            const SizedBox(height: 24),

            // زرار (إعادة إرسال الرمز)
            CustomForgetPasswordAndRecoveryTextButton(
              // لو الزرار مفعل هنكتب "إعادة إرسال الرمز"، لو مقفول هنكتب جنبها الثواني المتبقية زي "إعادة إرسال الرمز (45)"
              text: _isResendButtonEnabled
                  ? S.of(context).ResendCode
                  : '${S.of(context).ResendCode} ($_start)',
              alignment: AlignmentDirectional.center,
              textStyle: TextStyles.semiBold16.copyWith(
                color: _isResendButtonEnabled
                    ? AppColors.green1_600
                    : AppColors.grayscale400,
                height: 1.40,
              ),
              // لو الزرار مفعل، هنشغل دالة startTimer اللي بتشغل العداد وتقفل الزرار
              onPressed: _isResendButtonEnabled ? startTimer : null,
            ),
          ],
        ),
      ),
    );
  }
}
