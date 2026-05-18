/*
هذا الملف عبارة عن Abstract Class (واجهة برمجية) يحدد العمليات الأساسية التي نحتاجها من قاعدة البيانات (مثل إضافة بيانات، جلب بيانات، أو التحقق من وجودها).

الهدف من إنشاء هذا الملف هو:
1. التجريد (Abstraction): فصل منطق العمل (Business Logic) عن طريقة التنفيذ الفعلية. التطبيق لا يعرف إذا كنا نستخدم Firestore أو Supabase أو أي قاعدة بيانات أخرى.
2. سهولة التغيير: إذا قررنا مستقبلاً تغيير Firebase واستخدام قاعدة بيانات أخرى، سنقوم فقط بإنشاء Implementation جديد لهذا الـ Interface دون الحاجة لتغيير الكود في باقي أجزاء التطبيق.
3. تسهيل الاختبار (Testing): يمكننا إنشاء "MockDatabaseService" بسهولة لاختبار التطبيق دون الحاجة للاتصال الفعلي بقاعدة البيانات.
*/


abstract class DatabaseService {
  Future<void> addData({
    required String path,
    required Map<String, dynamic> data,
    String? documentId,
  });

  Future<Map<String, dynamic>> getData({
    required String path,
    required String documentId,
  });

  Future<bool> checkIfDataExists({
    required String path,
    required String documentId,
  });
}
