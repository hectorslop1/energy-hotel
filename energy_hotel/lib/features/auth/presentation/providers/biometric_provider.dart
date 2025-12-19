import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:local_auth/local_auth.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/services/biometric_service.dart';
import 'auth_provider.dart';

final biometricServiceProvider = Provider<BiometricService>((ref) {
  return BiometricService();
});

final biometricEnabledProvider =
    StateNotifierProvider<BiometricNotifier, BiometricState>((ref) {
      return BiometricNotifier(
        secureStorage: ref.watch(secureStorageProvider),
        biometricService: ref.watch(biometricServiceProvider),
      );
    });

class BiometricState {
  final bool isEnabled;
  final bool isAvailable;
  final BiometricType? biometricType;
  final bool isLoading;

  const BiometricState({
    this.isEnabled = false,
    this.isAvailable = false,
    this.biometricType,
    this.isLoading = false,
  });

  BiometricState copyWith({
    bool? isEnabled,
    bool? isAvailable,
    BiometricType? biometricType,
    bool? isLoading,
  }) {
    return BiometricState(
      isEnabled: isEnabled ?? this.isEnabled,
      isAvailable: isAvailable ?? this.isAvailable,
      biometricType: biometricType ?? this.biometricType,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  bool get isFaceId => biometricType == BiometricType.face;
  bool get isFingerprint =>
      biometricType == BiometricType.fingerprint ||
      biometricType == BiometricType.strong;
}

class BiometricNotifier extends StateNotifier<BiometricState> {
  final FlutterSecureStorage _secureStorage;
  final BiometricService _biometricService;

  static const String _credentialsEmailKey = 'biometric_credentials_email';
  static const String _credentialsPasswordKey =
      'biometric_credentials_password';

  BiometricNotifier({
    required FlutterSecureStorage secureStorage,
    required BiometricService biometricService,
  }) : _secureStorage = secureStorage,
       _biometricService = biometricService,
       super(const BiometricState()) {
    _init();
  }

  Future<void> _init() async {
    state = state.copyWith(isLoading: true);

    final isAvailable = await _biometricService.isAvailable();
    final biometrics = await _biometricService.getAvailableBiometrics();
    final isEnabled =
        await _secureStorage.read(key: AppConstants.biometricEnabledKey) ==
        'true';

    BiometricType? primaryType;
    if (biometrics.contains(BiometricType.face)) {
      primaryType = BiometricType.face;
    } else if (biometrics.contains(BiometricType.fingerprint)) {
      primaryType = BiometricType.fingerprint;
    } else if (biometrics.contains(BiometricType.strong)) {
      primaryType = BiometricType.strong;
    }

    state = BiometricState(
      isEnabled: isEnabled && isAvailable,
      isAvailable: isAvailable,
      biometricType: primaryType,
      isLoading: false,
    );
  }

  Future<bool> enableBiometric({
    required String email,
    required String password,
    required String localizedReason,
  }) async {
    state = state.copyWith(isLoading: true);

    try {
      final authenticated = await _biometricService.authenticate(
        localizedReason: localizedReason,
        biometricOnly: true,
      );

      if (authenticated) {
        await _secureStorage.write(key: _credentialsEmailKey, value: email);
        await _secureStorage.write(
          key: _credentialsPasswordKey,
          value: password,
        );
        await _secureStorage.write(
          key: AppConstants.biometricEnabledKey,
          value: 'true',
        );

        state = state.copyWith(isEnabled: true, isLoading: false);
        return true;
      }
    } catch (e) {
      // Handle error silently
    }

    state = state.copyWith(isLoading: false);
    return false;
  }

  Future<void> disableBiometric() async {
    state = state.copyWith(isLoading: true);

    await _secureStorage.delete(key: _credentialsEmailKey);
    await _secureStorage.delete(key: _credentialsPasswordKey);
    await _secureStorage.delete(key: AppConstants.biometricEnabledKey);

    state = state.copyWith(isEnabled: false, isLoading: false);
  }

  Future<Map<String, String>?> authenticateAndGetCredentials({
    required String localizedReason,
  }) async {
    try {
      final authenticated = await _biometricService.authenticate(
        localizedReason: localizedReason,
        biometricOnly: true,
      );

      if (authenticated) {
        final email = await _secureStorage.read(key: _credentialsEmailKey);
        final password = await _secureStorage.read(
          key: _credentialsPasswordKey,
        );

        if (email != null && password != null) {
          return {'email': email, 'password': password};
        }
      }
    } catch (e) {
      // Handle error silently
    }

    return null;
  }

  Future<bool> hasStoredCredentials() async {
    final email = await _secureStorage.read(key: _credentialsEmailKey);
    final password = await _secureStorage.read(key: _credentialsPasswordKey);
    return email != null && password != null;
  }

  Future<void> refresh() async {
    await _init();
  }
}
