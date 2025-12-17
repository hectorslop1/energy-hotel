import '../entities/user.dart';

abstract class AuthRepository {
  Future<User?> login(String email, String password);
  Future<void> logout();
  Future<User?> getCurrentUser();
  Future<bool> hasActiveSession();
  Future<void> saveSession(User user);
  Future<void> clearSession();
}
