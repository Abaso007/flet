import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

import '../models/control.dart';

/// Checks if the current platform is a desktop platform.
bool isDesktopPlatform() {
  return !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.windows ||
          defaultTargetPlatform == TargetPlatform.macOS ||
          defaultTargetPlatform == TargetPlatform.linux);
}

/// Checks if the current platform is Windows desktop.
bool isWindowsDesktop() {
  return !kIsWeb && (defaultTargetPlatform == TargetPlatform.windows);
}

/// Checks if the current platform is macOS desktop.
bool isMacOSDesktop() {
  return !kIsWeb && (defaultTargetPlatform == TargetPlatform.macOS);
}

/// Checks if the current platform is Linux desktop.
bool isLinuxDesktop() {
  return !kIsWeb && (defaultTargetPlatform == TargetPlatform.linux);
}

/// Checks if the current platform is a mobile (iOS or Android) platform.
bool isMobilePlatform() {
  return !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.android);
}

/// Checks if the current platform is iOS mobile.
bool isIOSMobile() {
  return !kIsWeb && (defaultTargetPlatform == TargetPlatform.iOS);
}

/// Checks if the current platform is Android mobile.
bool isAndroidMobile() {
  return !kIsWeb && (defaultTargetPlatform == TargetPlatform.android);
}

/// Checks if the current platform is an Apple platform (iOS or macOS).
bool isApplePlatform() {
  return !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.iOS ||
          defaultTargetPlatform == TargetPlatform.macOS);
}

/// Checks if the current platform is a web platform.
bool isWebPlatform() {
  return kIsWeb == true;
}

TargetPlatform? parseTargetPlatform(String? value,
    [TargetPlatform? defaultValue]) {
  if (value == null) return defaultValue;
  return TargetPlatform.values.firstWhereOrNull(
          (e) => e.name.toLowerCase() == value.toLowerCase()) ??
      defaultValue;
}

extension PlatformParsers on Control {
  TargetPlatform? getTargetPlatform(String propertyName,
      [TargetPlatform? defaultValue]) {
    return parseTargetPlatform(get(propertyName), defaultValue);
  }
}
