import 'package:flutter_test/flutter_test.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';
import 'package:windows_notification/windows_notification_platform_interface.dart';
import 'package:windows_notification/windows_notification_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockWindowsNotificationPlatform
    with MockPlatformInterfaceMixin
    implements WindowsNotificationPlatform {
  @override
  Future<void> clearNotificationHistory(String? applicationId) {
    throw UnimplementedError();
  }

  @override
  Future<void> initNotificationCallBack(OnTapNotification? callback) {
    // TODO: implement initNotificationCallBack
    throw UnimplementedError();
  }

  @override
  Future<void> removeNotification(
      String id, String group, String? applicationId) {
    // TODO: implement removeNotification
    throw UnimplementedError();
  }

  @override
  Future<void> removeNotificationGroup(String group, String? applicationId) {
    // TODO: implement removeNotificationGroup
    throw UnimplementedError();
  }

  @override
  Future<void> showNotification(
      NotificationMessage notification, String? applicationId) {
    // TODO: implement showNotification
    throw UnimplementedError();
  }

  @override
  Future<void> showNotificationCustomTemplate(NotificationMessage notification,
      String? applicationId, String template) {
    // TODO: implement showNotificationCustomTemplate
    throw UnimplementedError();
  }
}

void main() {
  final WindowsNotificationPlatform initialPlatform =
      WindowsNotificationPlatform.instance;

  test('$MethodChannelWindowsNotification is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelWindowsNotification>());
  });

  test('getPlatformVersion', () async {
    MockWindowsNotificationPlatform fakePlatform =
        MockWindowsNotificationPlatform();
    WindowsNotificationPlatform.instance = fakePlatform;
  });
}
