import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

import 'windows_notification_method_channel.dart';

abstract class WindowsNotificationPlatform extends PlatformInterface {
  /// Constructs a WindowsNotificationPlatform.
  WindowsNotificationPlatform() : super(token: _token);

  static final Object _token = Object();

  static WindowsNotificationPlatform _instance =
      MethodChannelWindowsNotification();

  /// The default instance of [WindowsNotificationPlatform] to use.
  ///
  /// Defaults to [MethodChannelWindowsNotification].
  static WindowsNotificationPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [WindowsNotificationPlatform] when
  /// they register themselves.0
  static set instance(WindowsNotificationPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<void> showNotification(
      final NotificationMessage notification, final String? applicationId) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> showNotificationCustomTemplate(
      final NotificationMessage notification,
      final String? applicationId,
      final String template) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> initNotificationCallBack(OnTapNotification? callback) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> clearNotificationHistory(final String? applicationId) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> removeNotification(
      final String id, final String group, final String? applicationId) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> removeNotificationGroup(
      final String group, final String? applicationId) {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
