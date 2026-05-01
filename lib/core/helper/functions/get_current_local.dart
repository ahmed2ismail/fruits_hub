import 'package:intl/intl.dart';

/// Checks if the current locale is English.
/// Returns true if the language code starts with 'en', false otherwise.
// Intl.getCurrentLocale() returns the locale string, e.g., 'en', 'ar', 'en_US'.
bool isEnglish() => Intl.getCurrentLocale().startsWith('en');
bool isArabic() => Intl.getCurrentLocale().startsWith('ar');
