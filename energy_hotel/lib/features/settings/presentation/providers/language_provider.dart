import 'package:flutter_riverpod/flutter_riverpod.dart';

class Language {
  final String code;
  final String name;
  final String nativeName;
  final String flag;

  const Language({
    required this.code,
    required this.name,
    required this.nativeName,
    required this.flag,
  });
}

const availableLanguages = [
  Language(code: 'en', name: 'English', nativeName: 'English', flag: '🇺🇸'),
  Language(code: 'es', name: 'Spanish', nativeName: 'Español', flag: '🇪🇸'),
];

final selectedLanguageProvider = StateProvider<Language>((ref) {
  return availableLanguages.first; // Default to English
});
