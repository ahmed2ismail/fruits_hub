/*
كيفية الاستخدام:
// 1. التحقق من الحقول المطلوبة (مثل العنوان أو المدينة):
// validator: (value) => AppValidators.validateRequired(value, fieldName: 'العنوان')

// 2. التحقق من البريد الإلكتروني:
// validator: AppValidators.validateEmail

// 3. التحقق من كلمة المرور (طول 8 أحرف):
// validator: AppValidators.validatePassword

// 4. التحقق من تطابق كلمة المرور (تأكيد كلمة المرور):
// validator: (value) => AppValidators.validateConfirmPassword(value, _passwordController.text)

// 5. التحقق من الاسم الكامل (حروف فقط):
// validator: AppValidators.validateFullName

// 6. التحقق من رقم الهاتف:
// validator: AppValidators.validatePhoneNumber

// 7. التحقق من الأرقام فقط (مثل العمر أو السعر):
// validator: AppValidators.validateNumbersOnly

// ملاحظة: تأكد من ضبط اللغة في بداية التطبيق ليظهر الخطأ باللغة المناسبة:
// AppValidators.isArabic = true; // للغة العربية
// AppValidators.isArabic = false; // للغة الإنجليزية
دالة الـ trim() اللي أضفناها للإيميل والاسم مهمة جداً لأن الكيبورد في الموبايل أحياناً يضع مسافة تلقائية في نهاية الكلام، وبدونها قد يتم اعتبار الإيميل خاطئاً!
*/

class AppValidators {
  // =========================================
  // --- إعدادات اللغة (Language Configuration) ---
  // =========================================
  /// يمكنك تغيير هذه القيمة من أي مكان في التطبيق عند تغيير اللغة (مثلاً في الـ Locale Cubit)
  /// AppValidators.isArabic = true;
  /// وإذا كان التطبيق بلغة واحدة، ثبت القيمة هنا ولن ينهار الكود في أي مشروع آخر.
  static bool isArabic = true;
  // static bool isEnglish = true;

  // =========================================
  // --- التعابير النمطية (Regex Patterns) ---
  // =========================================

  // التحقق من الاسم (يقبل حروف عربية وإنجليزية ومسافات فقط - يمنع الأرقام والرموز)
  static final RegExp _nameRegex = RegExp(r"^[\u0600-\u06FFa-zA-Z\s]+$");

  // التحقق من صيغة الإيميل بشكل دقيق جداً
  static final RegExp _emailRegex = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  // التحقق من رقم الهاتف (يقبل الأرقام وعلامة + ويبدأ من 9 إلى 15 رقم كمعيار دولي)
  static final RegExp _phoneRegex = RegExp(r"^\+?[0-9]{9,15}$");

  // التحقق من كلمة المرور القوية (على الأقل 8 أحرف، تحتوي على حرف كبير، حرف صغير، ورقم)
  static final RegExp _strongPasswordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d\w\W]{8,}$',
  );

  // التحقق من الروابط (URLs)
  static final RegExp _urlRegex = RegExp(
    r"^(https?:\/\/)?([\da-z\.-]+)\.([a-z\.]{2,6})([\/\w \.-]*)*\/?$",
  );

  // التحقق من الحروف العربية فقط (يسمح بالمسافات)
  static final RegExp _arabicOnlyRegex = RegExp(r"^[\u0600-\u06FF\s]+$");

  // التحقق من الأرقام فقط (بدون أي حروف أو رموز)
  static final RegExp _numbersOnlyRegex = RegExp(r"^[0-9]+$");

  // =========================================
  // --- دوال التحقق (Validation Methods) ---
  // =========================================

  // 1. دالة عامة لأي حقل مطلوب (مثل العنوان، اسم المدينة، إلخ)
  static String? validateRequired(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return isArabic
          ? 'الرجاء إدخال ${fieldName ?? 'هذا الحقل'}.'
          : 'Please enter ${fieldName ?? 'this field'}';
    }
    return null;
  }

  // 2. التحقق من الاسم الكامل
  static String? validateFullName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return isArabic
          ? "الرجاء إدخال الاسم الكامل."
          : 'Please enter your full name';
    }

    final trimmedValue = value.trim();

    if (!_nameRegex.hasMatch(trimmedValue)) {
      return isArabic
          ? 'الرجاء إدخال حروف صحيحة فقط (بدون أرقام أو رموز).'
          : 'Please enter valid characters only (no numbers or symbols).';
    } else if (value.trim().length < 3) {
      return isArabic
          ? 'الاسم الكامل يجب ألا يقل عن 3 أحرف.'
          : 'Full name must be at least 3 characters';
    }
    return null;
  }

  // 2.1 التحقق من الاسم الرباعي (التأكد من وجود 4 مقاطع على الأقل)
  static String? validateQuadrupleName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return isArabic ? "الرجاء إدخال الاسم." : 'Please enter your full name';
    }

    final trimmedValue = value.trim();

    if (!_nameRegex.hasMatch(trimmedValue)) {
      return isArabic
          ? 'الرجاء إدخال حروف صحيحة فقط (بدون أرقام أو رموز).'
          : 'Please enter valid characters only (no numbers or symbols).';
    }

    // تقسيم النص بناءً على المسافات، وحساب عدد الكلمات
    final parts = trimmedValue.split(RegExp(r'\s+'));
    if (parts.length < 4) {
      return isArabic
          ? 'الرجاء إدخال الاسم الرباعي كاملاً.'
          : 'Please enter your quadruple name';
    }
    return null;
  }

  // 3. التحقق من البريد الإلكتروني (باستخدام Regex)
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return isArabic
          ? 'الرجاء إدخال البريد الإلكتروني.'
          : 'Please enter your email';
    } else if (!_emailRegex.hasMatch(value.trim())) {
      return isArabic
          ? 'الرجاء إدخال بريد إلكتروني صالح.'
          : 'Please enter a valid email address';
    }
    return null;
  }

  // 4. التحقق من كلمة المرور (العادية - طول فقط)
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return isArabic
          ? 'الرجاء إدخال كلمة المرور.'
          : 'Please enter your password';
    } else if (value.length < 8) {
      return isArabic
          ? 'كلمة المرور يجب ألا تقل عن 8 أحرف.'
          : 'Password must be at least 8 characters';
    }
    return null;
  }

  // 5. التحقق من كلمة المرور (القوية) - استخدمها لو التطبيق يحتاج أمان عالي
  static String? validateStrongPassword(String? value) {
    if (value == null || value.isEmpty) {
      return isArabic
          ? 'الرجاء إدخال كلمة المرور.'
          : 'Please enter your password';
    } else if (!_strongPasswordRegex.hasMatch(value)) {
      return isArabic
          ? 'كلمة المرور يجب ألا تقل عن 8 أحرف، وتحتوي على حرف كبير، حرف صغير، ورقم.'
          : 'Password must be at least 8 characters, include an uppercase letter, a lowercase letter, and a number';
    }
    return null;
  }

  // 6. التحقق من تطابق كلمتي المرور (تأكيد كلمة المرور)
  static String? validateConfirmPassword(
    String? value,
    String? originalPassword,
  ) {
    if (value == null || value.isEmpty) {
      return isArabic
          ? 'الرجاء تأكيد كلمة المرور.'
          : 'Please confirm your password';
    } else if (value != originalPassword) {
      return isArabic
          ? 'كلمتا المرور غير متطابقتين.'
          : 'Passwords do not match';
    }
    return null;
  }

  // 7. التحقق من رقم الهاتف
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return isArabic
          ? 'الرجاء إدخال رقم الهاتف.'
          : 'Please enter your phone number';
    } else if (!_phoneRegex.hasMatch(value.trim())) {
      return isArabic
          ? 'الرجاء إدخال رقم هاتف صالح.'
          : 'Please enter a valid phone number';
    }
    return null;
  }

  // 8. التحقق من النصوص العربية فقط (مفيد في تطبيقات الحكومات أو الإدارات)
  static String? validateArabicTextOnly(String? value) {
    if (value == null || value.trim().isEmpty) {
      return isArabic ? 'هذا الحقل مطلوب.' : 'This field is required';
    } else if (!_arabicOnlyRegex.hasMatch(value)) {
      return isArabic
          ? 'الرجاء إدخال حروف عربية فقط.'
          : 'Please enter Arabic characters only';
    }
    return null;
  }

  // 9. التحقق من الأرقام فقط (مفيد في العمر، الكميات، الأسعار المكتوبة كأرقام صحيحة)
  static String? validateNumbersOnly(String? value) {
    if (value == null || value.trim().isEmpty) {
      return isArabic ? 'الرجاء إدخال رقم.' : 'Please enter a number';
    } else if (!_numbersOnlyRegex.hasMatch(value.trim())) {
      return isArabic
          ? 'الرجاء إدخال أرقام صحيحة فقط.'
          : 'Please enter a valid number (digits only)';
    }
    return null;
  }

  // 10. التحقق من الروابط (URLs) (مفيد لو المستخدم بيدخل رابط لحسابه أو موقعه)
  static String? validateUrl(String? value) {
    if (value == null || value.trim().isEmpty) {
      return isArabic ? 'الرجاء إدخال الرابط.' : 'Please enter a URL';
    } else if (!_urlRegex.hasMatch(value.trim())) {
      return isArabic ? 'الرجاء إدخال رابط صحيح.' : 'Please enter a valid URL';
    }
    return null;
  }

  // 11. التحقق الديناميكي من طول النص (أنت تحدد الحد الأدنى والأقصى)
  static String? validateLength(
    String? value, {
    required int min,
    required int max,
  }) {
    if (value == null || value.trim().isEmpty) {
      return isArabic ? 'هذا الحقل مطلوب.' : 'This field is required';
    }
    final length = value.trim().length;
    if (length < min || length > max) {
      return isArabic
          ? 'يجب أن يكون النص بين $min و $max حرفاً.'
          : 'Length must be between $min and $max characters';
    }
    return null;
  }
}
