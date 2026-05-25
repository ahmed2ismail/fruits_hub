import 'dart:convert';

import 'package:fruits_hub/core/helper/functions/get_current_local.dart';
import 'package:fruits_hub/core/services/shared_preferences_singleton.dart';
import 'package:fruits_hub/core/utils/app_constants.dart';
import 'package:fruits_hub/features/auth/data/models/user_model.dart';
import 'package:fruits_hub/features/auth/domain/entities/user_entity.dart';

UserEntity getUser() {
  var jsonString = Prefs.getString(AppConstants.kUserData);
  if (jsonString != null) {
    var userEntity = UserModel.fromjson(jsonDecode(jsonString));
    return userEntity;
  } else {
    // يفضل إرجاع مستخدم افتراضي بدلاً من رمي خطأ (Exception) لتجنب حدوث كراش في واجهة المستخدم
    return UserEntity(name: isArabic() ? 'ضيف' : 'Guest', email: '', uId: '');
  }
}
