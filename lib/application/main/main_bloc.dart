// ignore_for_file: library_private_types_in_public_api

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:greezy/domain/enums/enums.dart';
import 'package:greezy/domain/services/services.dart';

part 'main_bloc.freezed.dart';
part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  final LoggingService _logger;
  final GreezyService _greezyService;
  final SettingsService _settingsService;
  final DeviceInfoService _deviceInfoService;

  _MainLoadedState get currentState => state as _MainLoadedState;

  MainBloc(this._logger, this._greezyService, this._settingsService, this._deviceInfoService) : super(const _MainLoadingState()) {
    on<_Init>(_mapInitToState);
    on<_ThemeChanged>(_mapThemeChangedToState);
    on<_ThemeModeChanged>(_mapThemeModeChangedToState);
  }

  MainState _loadedState(AppThemeType theme, AutoThemeModeType autoThemeMode, {bool isInitialized = true}) {
    return MainState.loaded(
      appTitle: _deviceInfoService.appName,
      initialized: isInitialized,
      theme: theme,
      autoThemeMode: autoThemeMode,
      firstInstall: _settingsService.isFirstInstall,
      versionChanged: _deviceInfoService.versionChanged,
    );
  }

  Future<void> _mapInitToState(_Init event, Emitter<MainState> emit, {bool init = true}) async {
    _logger.info(runtimeType, '_init: Initializing all...');
    await _greezyService.init(_settingsService.language);

    final settings = _settingsService.appSettings;

    _logger.info(runtimeType, '_init: Is first install = ${_settingsService.isFirstInstall}' '-- versionChanged = ${_deviceInfoService.versionChanged}');

    final state = _loadedState(settings.appTheme, settings.themeMode, isInitialized: init);

    if (init) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    emit(state);
  }

  Future<void> _mapThemeChangedToState(_ThemeChanged event, Emitter<MainState> emit) async {
    _logger.info(runtimeType, '_init: Is first install = ${_settingsService.isFirstInstall}' '-- versionChanged = ${_deviceInfoService.versionChanged}');

    emit(_loadedState(event.newValue, _settingsService.autoThemeMode, isInitialized: true));
  }

  Future<void> _mapThemeModeChangedToState(_ThemeModeChanged event, Emitter<MainState> emit) async {
    _logger.info(runtimeType, '_init: Is first install = ${_settingsService.isFirstInstall}' '-- versionChanged = ${_deviceInfoService.versionChanged}');

    emit(_loadedState(_settingsService.appTheme, event.newValue, isInitialized: true));
  }
}