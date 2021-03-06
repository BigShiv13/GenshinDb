import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:package_info/package_info.dart';

import '../../common/enums/app_accent_color_type.dart';
import '../../common/enums/app_language_type.dart';
import '../../common/enums/app_theme_type.dart';
import '../../services/settings_service.dart';
import '../bloc.dart';

part 'settings_bloc.freezed.dart';
part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsService _settingsService;
  final MainBloc _mainBloc;

  SettingsBloc(this._settingsService, this._mainBloc) : super(const SettingsState.loading());

  _LoadedState get currentState => state as _LoadedState;

  @override
  Stream<SettingsState> mapEventToState(
    SettingsEvent event,
  ) async* {
    final s = await event.map(
      init: (_) async {
        await _settingsService.init();
        final settings = _settingsService.appSettings;
        final packageInfo = await PackageInfo.fromPlatform();
        return SettingsState.loaded(
          currentTheme: settings.appTheme,
          currentAccentColor: settings.accentColor,
          currentLanguage: settings.appLanguage,
          appVersion: packageInfo.version,
          showCharacterDetails: settings.showCharacterDetails,
          showWeaponDetails: settings.showWeaponDetails,
        );
      },
      themeChanged: (event) async {
        _settingsService.appTheme = event.newValue;
        _mainBloc.add(MainEvent.themeChanged(newValue: event.newValue));
        return currentState.copyWith.call(currentTheme: event.newValue);
      },
      accentColorChanged: (event) async {
        _settingsService.accentColor = event.newValue;
        _mainBloc.add(MainEvent.accentColorChanged(newValue: event.newValue));
        return currentState.copyWith.call(currentAccentColor: event.newValue);
      },
      languageChanged: (event) async {
        _settingsService.language = event.newValue;
        _mainBloc.add(MainEvent.languageChanged(newValue: event.newValue));
        return currentState.copyWith.call(currentLanguage: event.newValue);
      },
      showCharacterDetailsChanged: (event) async {
        _settingsService.showCharacterDetails = event.newValue;
        return currentState.copyWith.call(showCharacterDetails: event.newValue);
      },
      showWeaponDetailsChanged: (event) async {
        _settingsService.showWeaponDetails = event.newValue;
        return currentState.copyWith.call(showWeaponDetails: event.newValue);
      },
    );

    yield s;
  }
}
