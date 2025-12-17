import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_mock_datasource.dart';
import '../models/user_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthLocalDataSource _localDataSource;
  final AuthMockDataSource _mockDataSource;

  AuthRepositoryImpl({
    required AuthLocalDataSource localDataSource,
    required AuthMockDataSource mockDataSource,
  }) : _localDataSource = localDataSource,
       _mockDataSource = mockDataSource;

  @override
  Future<User?> login(String email, String password) async {
    final user = await _mockDataSource.login(email, password);
    if (user != null) {
      await _localDataSource.saveSession(user);
    }
    return user;
  }

  @override
  Future<void> logout() async {
    await _localDataSource.clearSession();
  }

  @override
  Future<User?> getCurrentUser() async {
    return await _localDataSource.getSession();
  }

  @override
  Future<bool> hasActiveSession() async {
    return await _localDataSource.hasSession();
  }

  @override
  Future<void> saveSession(User user) async {
    await _localDataSource.saveSession(UserModel.fromEntity(user));
  }

  @override
  Future<void> clearSession() async {
    await _localDataSource.clearSession();
  }
}
