abstract class AppConstants {
  static const String appName = 'Energy Hotel';
  
  static const double hotelLatitude = 20.6534;
  static const double hotelLongitude = -87.0793;
  
  static const String defaultLocale = 'en';
  static const List<String> supportedLocales = ['en', 'es'];
  
  static const String sessionKey = 'user_session';
  static const String biometricEnabledKey = 'biometric_enabled';
  static const String languageKey = 'app_language';
  static const String cardsKey = 'saved_cards';
  
  static const int sessionExpirationDays = 30;
}
