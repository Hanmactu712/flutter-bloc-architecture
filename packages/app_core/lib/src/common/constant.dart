import 'package:flutter/material.dart';

class Constant {
  static Color primaryColor = const Color(0xFF326B70);

  //local storage key
  static String lsSettings = 'app_settings';
  static String lsIdentity = 'app_identity';

  static Widget spacerSm = const SizedBox(height: 8, width: 8);
  static Widget spacerMd = const SizedBox(height: 16, width: 16);
  static Widget spacerLg = const SizedBox(height: 24, width: 24);

  static String androidPackageId = 'com.ducdd.my_marker';
  static String appStoreIssuerId = 'App Store Key issuer ID';
  static String appStoreKeyId = '';
  static String appStoreSharedSecret = 'App Store shared secret';
  static String bundleId = 'your iOS bundle ID';
  static String googlePlayProjectName = 'my-marker';

  //language map
  static Map<String, Map<String, String>> languageMap = {
    'en': {
      'en': 'English',
      'vi': 'Vietnamese',
      'fr': 'French',
      'de': 'German',
      'es': 'Spanish',
      'it': 'Italian',
      'pt': 'Portuguese',
      'ru': 'Russian',
      'ja': 'Japanese',
      'ko': 'Korean',
      'zh': 'Chinese',
      "ar": "Arabic",
    },
    'vi': {
      'en': 'Tiếng Anh',
      'vi': 'Tiếng Việt',
      'fr': 'Tiếng Pháp',
      'de': 'Tiếng Đức',
      'es': 'Tiếng Tây Ban Nha',
      'it': 'Tiếng Ý',
      'pt': 'Tiếng Bồ Đào Nha',
      'ru': 'Tiếng Nga',
      'ja': 'Tiếng Nhật',
      'ko': 'Tiếng Hàn',
      'zh': 'Tiếng Trung',
      "ar": "Tiếng Ả Rập",
    },
    'fr': {
      'en': 'Anglais',
      'vi': 'Vietnamien',
      'fr': 'Français',
      'de': 'Allemand',
      'es': 'Espagnol',
      'it': 'Italien',
      'pt': 'Portugais',
      'ru': 'Russe',
      'ja': 'Japonais',
      'ko': 'Coréen',
      'zh': 'Chinois',
      "ar": "Arabe",
    },
    'de': {
      'en': 'Englisch',
      'vi': 'Vietnamesisch',
      'fr': 'Französisch',
      'de': 'Deutsch',
      'es': 'Spanisch',
      'it': 'Italienisch',
      'pt': 'Portugiesisch',
      'ru': 'Russisch',
      'ja': 'Japanisch',
      'ko': 'Koreanisch',
      'zh': 'Chinesisch',
      "ar": "Arabisch",
    },
    'es': {
      'en': 'Inglés',
      'vi': 'Vietnamita',
      'fr': 'Francés',
      'de': 'Alemán',
      'es': 'Español',
      'it': 'Italiano',
      'pt': 'Portugués',
      'ru': 'Ruso',
      'ja': 'Japonés',
      'ko': 'Coreano',
      'zh': 'Chino',
      "ar": "Árabe",
    },
    'it': {
      'en': 'Inglese',
      'vi': 'Vietnamita',
      'fr': 'Francese',
      'de': 'Tedesco',
      'es': 'Spagnolo',
      'it': 'Italiano',
      'pt': 'Portoghese',
      'ru': 'Russo',
      'ja': 'Giapponese',
      'ko': 'Coreano',
      'zh': 'Cinese',
      "ar": "Arabo",
    },
    'pt': {
      'en': 'Inglês',
      'vi': 'Vietnamita',
      'fr': 'Francês',
      'de': 'Alemão',
      'es': 'Espanhol',
      'it': 'Italiano',
      'pt': 'Português',
      'ru': 'Russo',
      'ja': 'Japonês',
      'ko': 'Coreano',
      'zh': 'Chinês',
      "ar": "Árabe",
    },
    'ru': {
      'en': 'Английский',
      'vi': 'Вьетнамский',
      'fr': 'Французский',
      'de': 'Немецкий',
      'es': 'Испанский',
      'it': 'Итальянский',
      'pt': 'Португальский',
      'ru': 'Русский',
      'ja': 'Японский',
      'ko': 'Корейский',
      'zh': 'Китайский',
      "ar": "Арабский",
    },
    'ja': {
      'en': '英語',
      'vi': 'ベトナム語',
      'fr': 'フランス語',
      'de': 'ドイツ語',
      'es': 'スペイン語',
      'it': 'イタリア語',
      'pt': 'ポルトガル語',
      'ru': 'ロシア語',
      'ja': '日本語',
      'ko': '韓国語',
      'zh': '中国語',
      "ar": "アラビア語",
    },
    'ko': {
      'en': '영어',
      'vi': '베트남어',
      'fr': '프랑스어',
      'de': '독일어',
      'es': '스페인어',
      'it': '이탈리아어',
      'pt': '포르투갈어',
      'ru': '러시아어',
      'ja': '일본어',
      'ko': '한국어',
      'zh': '중국어',
      "ar": "아랍어",
    },
    'zh': {
      'en': '英语',
      'vi': '越南语',
      'fr': '法语',
      'de': '德语',
      'es': '西班牙语',
      'it': '意大利语',
      'pt': '葡萄牙语',
      'ru': '俄语',
      'ja': '日语',
      'ko': '韩语',
      'zh': '中文',
      "ar": "阿拉伯语",
    },
    'ar': {
      'en': 'الإنجليزية',
      'vi': 'الفيتنامية',
      'fr': 'الفرنسية',
      'de': 'الألمانية',
      'es': 'الإسبانية',
      'it': 'الإيطالية',
      'pt': 'البرتغالية',
      'ru': 'الروسية',
      'ja': 'اليابانية',
      'ko': 'الكورية',
      'zh': 'الصينية',
      "ar": "العربية",
    },
  };
}

class AppIcons {
  static IconData home = Icons.home_outlined;
  static IconData menu = Icons.menu_outlined;
  static IconData marker = Icons.location_on_outlined;
  static IconData addMarker = Icons.add_location_alt_outlined;
  static IconData collection = Icons.folder_copy_outlined;
  static IconData addCollection = Icons.create_new_folder_outlined;
  static IconData tags = Icons.tag_outlined;
  static IconData setting = Icons.settings_outlined;
  static IconData logout = Icons.logout_outlined;
  static IconData add = Icons.add_outlined;
  static IconData edit = Icons.edit_outlined;
  static IconData delete = Icons.delete_outlined;
  static IconData search = Icons.search_outlined;
  static IconData close = Icons.close_outlined;
  static IconData save = Icons.save_outlined;
  static IconData cancel = Icons.cancel_outlined;
  static IconData back = Icons.arrow_back_outlined;
  static IconData forward = Icons.arrow_forward;
  static IconData refresh = Icons.refresh_outlined;
  static IconData password = Icons.password_outlined;
  static IconData description = Icons.description_outlined;
  static IconData uri = Icons.link_outlined;
  static IconData error = Icons.error_outline;
  static IconData secure = Icons.lock_outline;
  static IconData unsecure = Icons.lock_open_outlined;
  static IconData favorite = Icons.favorite_outline;
  static IconData brokenLink = Icons.link_off_outlined;
  static IconData more = Icons.more_vert_outlined;
  static IconData share = Icons.share_outlined;
  static IconData upgrade = Icons.upgrade_outlined;
}

class Resources {
  static String defaultImage =
      'https://img.freepik.com/premium-vector/default-image-icon-vector-missing-picture-page-website-design-mobile-app-no-photo-available_87543-11093.jpg';
  static String logo = 'assets/images/flutter_logo.png';
  static String branding = 'assets/images/flutter_brand.png';
  static String noImage = 'assets/images/no_image.png';
}

class LayoutSettings {
  double mainPadding;
  double mainMargin;
  double mainBorderRadius;
  double mainBorderWidth;

  LayoutSettings({required this.mainPadding, required this.mainMargin, required this.mainBorderRadius, required this.mainBorderWidth});

  static LayoutSettings mobile = LayoutSettings(mainPadding: 12, mainMargin: 12, mainBorderRadius: 4, mainBorderWidth: 1);
  static LayoutSettings tablet = LayoutSettings(mainPadding: 16, mainMargin: 16, mainBorderRadius: 6, mainBorderWidth: 1);
  static LayoutSettings desktop = LayoutSettings(mainPadding: 24, mainMargin: 24, mainBorderRadius: 8, mainBorderWidth: 1);
}
