/*
هتستخدم عشان تعرض بيانات المستخدم بغض النظر عن الخدمة المستخدمة اللي هي زي firebase, subabase, or other...
لان دي هي اللي هترجعلي فيها البيانات في الاخر
*/

class UserEntity {
  final String name;
  final String email;
  final String uId;

  UserEntity({required this.name, required this.email, required this.uId});

  Map<String, dynamic> toMap() {
    return {'name': name, 'email': email, 'uId': uId};
  }
}
