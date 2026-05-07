// دا كلاس بنستخدمه عشان ن throw Exceptions زي ماحنا عايزين
class CustomException implements Exception {
  final String message;

  CustomException(this.message);

  @override
  String toString() {
    return message;
  }
}
