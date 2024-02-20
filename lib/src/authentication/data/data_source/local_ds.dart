import 'dart:convert';

import 'package:house_rental/src/authentication/data/models/user_model.dart';
import 'package:house_rental/src/authentication/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthenticationLocalDatasource {
  Future cacheUserData(User user);
  Future<UserModel> getUserCachedData();
}

class AuhenticationLocalDataSourceImpl
    implements AuthenticationLocalDatasource {
  final SharedPreferences sharedPreferences;
  final String cacheKey = "userCacheKey";

  AuhenticationLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future cacheUserData(User user) async {
    final jsonString = jsonEncode(user.toMap());

    return sharedPreferences.setString(cacheKey, jsonString);
  }

  @override
  Future<UserModel> getUserCachedData() async{
    final jsonString = sharedPreferences.getString(cacheKey);

    if (jsonString == null) {
      throw Exception("No user cache data");
    }
    return  UserModel.fromJson(json.decode(jsonString));
  }
}
