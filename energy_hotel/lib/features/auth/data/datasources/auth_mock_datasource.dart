import '../models/user_model.dart';

abstract class AuthMockDataSource {
  Future<UserModel?> login(String email, String password);
}

class AuthMockDataSourceImpl implements AuthMockDataSource {
  static const _mockUsers = [
    {
      'id': '1',
      'email': 'guest@energyhotel.com',
      'password': 'password123',
      'name': 'John Guest',
      'avatar_url': null,
    },
    {
      'id': '2',
      'email': 'demo@energyhotel.com',
      'password': 'demo123',
      'name': 'Demo User',
      'avatar_url': null,
    },
  ];

  @override
  Future<UserModel?> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));

    for (final user in _mockUsers) {
      if (user['email'] == email && user['password'] == password) {
        return UserModel(
          id: user['id'] as String,
          email: user['email'] as String,
          name: user['name'] as String,
          avatarUrl: user['avatar_url'],
        );
      }
    }
    return null;
  }
}
