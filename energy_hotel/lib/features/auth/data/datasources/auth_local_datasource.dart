import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<void> saveSession(UserModel user);
  Future<UserModel?> getSession();
  Future<void> clearSession();
  Future<bool> hasSession();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final FlutterSecureStorage _secureStorage;

  AuthLocalDataSourceImpl({required FlutterSecureStorage secureStorage})
    : _secureStorage = secureStorage;

  @override
  Future<void> saveSession(UserModel user) async {
    await _secureStorage.write(
      key: AppConstants.sessionKey,
      value: jsonEncode(user.toJson()),
    );
  }

  @override
  Future<UserModel?> getSession() async {
    final data = await _secureStorage.read(key: AppConstants.sessionKey);
    if (data == null) return null;
    return UserModel.fromJson(jsonDecode(data));
  }

  @override
  Future<void> clearSession() async {
    await _secureStorage.delete(key: AppConstants.sessionKey);
  }

  @override
  Future<bool> hasSession() async {
    final data = await _secureStorage.read(key: AppConstants.sessionKey);
    return data != null;
  }
}
