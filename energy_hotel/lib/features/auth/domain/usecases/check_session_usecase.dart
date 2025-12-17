import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class CheckSessionUseCase {
  final AuthRepository _repository;

  CheckSessionUseCase(this._repository);

  Future<User?> call() async {
    final hasSession = await _repository.hasActiveSession();
    if (hasSession) {
      return await _repository.getCurrentUser();
    }
    return null;
  }
}
