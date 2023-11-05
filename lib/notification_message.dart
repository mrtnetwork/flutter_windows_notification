import 'dart:convert';

/// https://learn.microsoft.com/en-us/uwp/api/windows.ui.notifications.toastdismissalreason?view=winrt-22621
enum EventType {
  onActivate,

  /// The app explicitly hid the toast notification by calling the ToastNotifier.hide method.
  onDismissedApplicationHidden,

  /// The user dismissed the toast notification.
  onDismissedUserCanceled,

  /// The toast notification had been shown for the maximum allowed time and was faded out.
  /// The maximum time to show a toast notification is 7 seconds except in the case of long-duration toasts,
  /// in which case it is 25 seconds.
  onDismissedTimedOut
}

enum TemplateType { plugin, custom }

class NotificationMessage {
  final TemplateType temolateType;
  final String? title;

  /// Gets or sets the group identifier for the notification.
  final String? group;
  final String? body;

  /// Thumbnail next to notification text
  final String? image;

  /// Large image at the bottom of the notification text
  final String? largeImage;
  final Map<String, dynamic> payload;

  /// Gets or sets the unique identifier of this notification within the notification Group.
  final String id;

  /// A string that is passed to the application when it is activated by the toast. The format and contents of this string are defined by the app for its own use. When the user taps or clicks the toast to launch its associated app, the launch string provides the context to the app that allows it to show the user a view relevant to the toast content, rather than launching in its default way.
  final String? launch;

  /// crete NotificationMessage object when you want to send notificaation with plugin template
  NotificationMessage.fromPluginTemplate(
    /// Gets or sets the unique identifier of this notification within the notification Group.
    this.id,
    String this.title,
    String this.body, {
    /// Thumbnail next to notification text
    this.image,
    this.payload = const {},

    /// A string that is passed to the application when it is activated by the toast. The format and contents of this string are defined by the app for its own use. When the user taps or clicks the toast to launch its associated app, the launch string provides the context to the app that allows it to show the user a view relevant to the toast content, rather than launching in its default way.
    this.launch,

    /// Large image at the bottom of the notification text
    this.largeImage,

    /// Gets or sets the group identifier for the notification.
    this.group,
  }) : temolateType = TemplateType.plugin {
    assert(id.trim().isNotEmpty, "id must not be empty string");
    assert(group == null || group!.trim().isNotEmpty,
        "group must not be empty string");
  }

  /// crete NotificationMessage object when you want to send notificaation with your own template
  NotificationMessage.fromCustomTemplate(
    /// Gets or sets the unique identifier of this notification within the notification Group.
    this.id, {
    this.payload = const {},

    /// A string that is passed to the application when it is activated by the toast. The format and contents of this string are defined by the app for its own use. When the user taps or clicks the toast to launch its associated app, the launch string provides the context to the app that allows it to show the user a view relevant to the toast content, rather than launching in its default way.
    this.launch,

    /// Gets or sets the group identifier for the notification.
    this.group,
  })  : temolateType = TemplateType.custom,
        title = null,
        image = null,
        largeImage = null,
        body = null {
    assert(id.trim().isNotEmpty, "id must not be empty string");
    assert(group == null || group!.trim().isNotEmpty,
        "group must not be empty string");
  }
  String get methodNmae => temolateType == TemplateType.custom
      ? "custom_template"
      : image == null
          ? "show_notification"
          : "show_notification_image";
  Map<String, dynamic> get toJs {
    final toJson = {
      "title": title,
      "body": body,
      "tag": id,
      "payload": payload,
      "group": group,
      "launch": launch,
      "temolateType": temolateType.name,
      "largImage": largeImage
    };
    if (image != null) {
      toJson["imgae"] = image;
    }

    return toJson;
  }

  NotificationMessage.fromJson(final Map<String, dynamic> json)
      : id = json["tag"],
        title = json["title"],
        body = json["body"],
        image = json["image"],
        payload = Map.from(json["payload"]),
        group = json["group"],
        largeImage = json["largImage"],
        launch = json["launch"],
        temolateType = TemplateType.values
            .firstWhere((element) => element.name == json["temolateType"]);

  Map<String, dynamic> get toJson {
    Map<String, dynamic> messageJs = {
      "title": title,
      "body": body,
      "tag": id,
      "largImage": largeImage,
      "payload": json.encode(toJs),
    };
    if (image != null) {
      messageJs["image"] = image!;
    }
    if (launch != null) {
      messageJs["launch"] = launch;
    }
    if (group != null) {
      messageJs["group"] = group;
    }
    return messageJs;
  }
}

class NotificationCallBackDetails {
  NotificationCallBackDetails(
      {required this.eventType,
      required this.message,
      required this.argrument,
      required this.userInput});

  /// event type
  final EventType eventType;

  /// notification messaage was send
  final NotificationMessage message;

  /// Gets the arguments associated with a toast action initiated by the user.
  /// This arguments string was included in the toast's XML payload.
  final String? argrument;

  /// For toast notifications that include text boxes for user input, contains the user input.
  final Map<String, dynamic> userInput;
}
