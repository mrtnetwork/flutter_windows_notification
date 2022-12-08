import 'package:windows_notification/notification_message.dart';

import 'windows_notification_platform_interface.dart';

typedef OnTapNotification = Function(
    NotificationMessage notification, EventType eventType, String? argrument);

class WindowsNotification {
  WindowsNotification({
    ///Creates and initializes a new instance of the ToastNotification, bound to a specified app, usually another app in the same package.
    required this.applicationId,
  });

  ///Creates and initializes a new instance of the ToastNotification, bound to a specified app, usually another app in the same package.
  String? applicationId;

  /// To send notifications with plugin templates you must create NotificationMessage with fromPluginTemplate constructor
  Future<void> showNotificationPluginTemplate(
      final NotificationMessage templaate) async {
    return WindowsNotificationPlatform.instance
        .showNotification(templaate, applicationId);
  }

  /// To send notifications with custom templates you must create NotificationMessage with fromCustomTemplate constructor
  Future<void> showNotificationCustomTemplate(
      final NotificationMessage notification, final String template) async {
    return WindowsNotificationPlatform.instance
        .showNotificationCustomTemplate(notification, applicationId, template);
  }

  /// onActivate and onDismissed events of your sending notifications
  Future<void> initNotificationCallBack(OnTapNotification? callback) async {
    return WindowsNotificationPlatform.instance
        .initNotificationCallBack(callback);
  }

  ///Removes all notifications sent by this app from action center.
  Future<void> clearNotificationHistory() {
    return WindowsNotificationPlatform.instance
        .clearNotificationHistory(applicationId);
  }

  /// Removes an individual toast, with the specified tag and group label, from action center.
  Future<void> removeNotificationId(final String id, final String group) {
    if (id.trim().isEmpty || group.trim().isEmpty) {
      return throw Exception("Group and id must not be empty string");
    }
    return WindowsNotificationPlatform.instance
        .removeNotification(id, group, applicationId);
  }

  ///Removes a group of toast notifications, identified by the specified group label, from action center.
  Future<void> removeNotificationGroup(final String group) {
    if (group.trim().isEmpty) {
      return throw Exception("Group not be empty string");
    }
    return WindowsNotificationPlatform.instance
        .removeNotificationGroup(group, applicationId);
  }
}
