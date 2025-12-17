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
  Language(code: 'fr', name: 'French', nativeName: 'Français', flag: '🇫🇷'),
  Language(code: 'de', name: 'German', nativeName: 'Deutsch', flag: '🇩🇪'),
  Language(code: 'it', name: 'Italian', nativeName: 'Italiano', flag: '🇮🇹'),
  Language(
    code: 'pt',
    name: 'Portuguese',
    nativeName: 'Português',
    flag: '🇧🇷',
  ),
  Language(code: 'zh', name: 'Chinese', nativeName: '中文', flag: '🇨🇳'),
  Language(code: 'ja', name: 'Japanese', nativeName: '日本語', flag: '🇯🇵'),
  Language(code: 'ko', name: 'Korean', nativeName: '한국어', flag: '🇰🇷'),
  Language(code: 'ar', name: 'Arabic', nativeName: 'العربية', flag: '🇸🇦'),
];

final selectedLanguageProvider = StateProvider<Language>((ref) {
  return availableLanguages.first; // Default to English
});
