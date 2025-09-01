part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

final class SettingsInitial extends SettingsState {}

final class SettingsLoading extends SettingsState {}

final class SettingsLoaded extends SettingsState {
  final Locale locale;
  final ThemeSettings themeSettings;
  const SettingsLoaded({required this.locale, required this.themeSettings});

  //copy with
  SettingsLoaded copyWith({Locale? locale, ThemeSettings? themeSettings, bool? isUpgradePremium}) {
    return SettingsLoaded(locale: locale ?? this.locale, themeSettings: themeSettings ?? this.themeSettings);
  }

  //to json
  Map<String, dynamic> toJson() {
    return {'languageCode': locale.languageCode, 'countryCode': locale.countryCode, 'themeSettings': themeSettings.toJson()};
  }

  //from json
  factory SettingsLoaded.fromJson(Map<String, dynamic> json) {
    return SettingsLoaded(
      locale: Locale(json['languageCode'] ?? "en", json['countryCode'] ?? "US"),
      themeSettings: ThemeSettings.fromJson(json['themeSettings']),
    );
  }

  @override
  List<Object?> get props => [locale, themeSettings];
}

final class SettingsError extends SettingsState {
  final String message;
  const SettingsError({required this.message});

  @override
  List<Object> get props => [message];
}
