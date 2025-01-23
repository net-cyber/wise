import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:wise/src/core/constants/app_constants.dart';
import 'package:wise/src/core/utils/local_storage_key.dart';

class LocalStorage {
  static SharedPreferences? _preferences;
  LocalStorage._();
  static LocalStorage? _localStorage;
  static LocalStorage instance = LocalStorage._();
  static Future<LocalStorage> getInstance() async {
    if (_localStorage == null){
      _localStorage = LocalStorage._();
      await _localStorage!._init();
    }
    return _localStorage!;
  }
  /// init shared preferences
  Future<void> _init() async {
    _preferences = await SharedPreferences.getInstance();
  }
  /// get is onboarding
  bool getIsDoneOnboarding() {
    final isDoneOnboarding = _preferences?.getBool(LocalStorageKey.isDoneOnboarding);
    if (isDoneOnboarding == null) {
      return false;
    }
    return isDoneOnboarding;
  }
  /// set is onboarding
  Future<void> setIsDoneOnboarding(bool value) async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.setBool(LocalStorageKey.isDoneOnboarding, value);
  }
  /// delete is onboarding
  Future<void> deleteIsDoneOnboarding() async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.remove(LocalStorageKey.isDoneOnboarding);
  }
  /// set refresh token
  Future<void> setRefreshToken(String token) async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.setString(LocalStorageKey.refreshToken, token);
  }
  /// get refresh token
  String? getRefreshToken() {
    if (_preferences == null) {
      return null;
    }
    return _preferences!.getString(LocalStorageKey.refreshToken);
  }
  /// delete refresh token
  Future<void> deleteRefreshToken() async {
    if (_preferences == null) {
      return;
    }
    await _preferences!.remove(LocalStorageKey.refreshToken);
  }
  /// set token
  Future<void> setAccessToken(String token) async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.setString(LocalStorageKey.accessToken, token);
  }
  /// get token
  String? getAccessToken() {
    if (_preferences == null) {
      return null;
    }
    return _preferences?.getString(LocalStorageKey.accessToken);
  }
  /// delete token
  Future<void> deleteAccessToken() async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.remove(LocalStorageKey.accessToken);
  }
  /// set is dark mode
  Future<void> setIsDarkMode(bool value) async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.setBool(LocalStorageKey.isDarkMode, value);
  }
  /// get is dark mode
  bool getIsDarkMode() {
    final isDarkMode = _preferences?.getBool(LocalStorageKey.isDarkMode);
    if (isDarkMode == null) {
      return false;
    }
    return isDarkMode;
  }
  /// clear all
  Future<void> clear() async {
    if (_preferences == null) {
      return;
    }
    await _preferences?.clear();
  }
  // set app theme mode
    Future<void> setAppThemeMode(bool isDarkMode) async {
      log('setAppThemeMode: $isDarkMode');
    if (_preferences != null) {
      await _preferences!.setBool(AppConstants.keyAppThemeMode, isDarkMode);
    }
  }

  bool getAppThemeMode() {
    log('getAppThemeMode ${_preferences?.getBool(AppConstants.keyAppThemeMode)}');
    return _preferences?.getBool(AppConstants.keyAppThemeMode) ?? false;
  }

  void deleteAppThemeMode() {
    log('deleteAppThemeMode');
    _preferences?.remove(AppConstants.keyAppThemeMode);
  }

}
