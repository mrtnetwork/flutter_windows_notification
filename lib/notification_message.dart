import 'dart:convert';

enum EventType { onActivate, onDismissed }

enum TemplateType { plugin, custom }

class NotificationMessage {
  final TemplateType temolateType;
  final String? title;

  ///Gets or sets the group identifier for the notification.
  final String? group;
  final String? body;

  ///Thumbnail next to notification text
  final String? image;

  ///Large image at the bottom of the notification text
  final String? largeImage;
  final Map<String, dynamic> payload;

  ///Gets or sets the unique identifier of this notification within the notification Group.
  final String id;

  ///A string that is passed to the application when it is activated by the toast. The format and contents of this string are defined by the app for its own use. When the user taps or clicks the toast to launch its associated app, the launch string provides the context to the app that allows it to show the user a view relevant to the toast content, rather than launching in its default way.
  final String? launch;

  /// crete NotificationMessage object when you want to send notificaation with plugin template
  NotificationMessage.fromPluginTemplate(
    ///Gets or sets the unique identifier of this notification within the notification Group.
    this.id,
    String this.title,
    String this.body, {

    ///Thumbnail next to notification text
    this.image,
    this.payload = const {},

    ///A string that is passed to the application when it is activated by the toast. The format and contents of this string are defined by the app for its own use. When the user taps or clicks the toast to launch its associated app, the launch string provides the context to the app that allows it to show the user a view relevant to the toast content, rather than launching in its default way.
    this.launch,

    ///Large image at the bottom of the notification text
    this.largeImage,

    ///Gets or sets the group identifier for the notification.
    this.group,
  }) : temolateType = TemplateType.plugin {
    assert(id.trim().isNotEmpty, "id must not be empty string");
    assert(group == null || group!.trim().isNotEmpty,
        "group must not be empty string");
  }

  /// crete NotificationMessage object when you want to send notificaation with your own template
  NotificationMessage.fromCustomTemplate(
    ///Gets or sets the unique identifier of this notification within the notification Group.
    this.id, {
    this.payload = const {},

    ///A string that is passed to the application when it is activated by the toast. The format and contents of this string are defined by the app for its own use. When the user taps or clicks the toast to launch its associated app, the launch string provides the context to the app that allows it to show the user a view relevant to the toast content, rather than launching in its default way.
    this.launch,

    ///Gets or sets the group identifier for the notification.
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
    if (image != null) {
      return {
        "title": title,
        "body": body,
        "image": image!,
        "tag": id,
        "payload": payload,
        "group": group,
        "launch": launch,
        "temolateType": temolateType.name,
        "largImage": largeImage
      };
    }
    return {
      "title": title,
      "body": body,
      "tag": id,
      "payload": payload,
      "group": group,
      "launch": launch,
      "temolateType": temolateType.name,
      "largImage": largeImage
    };
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
    Map<String, dynamic> messageJs = {};
    if (image != null) {
      messageJs = {
        "title": title,
        "body": body,
        "image": image!,
        "payload": json.encode(toJs),
        "tag": id,
        "largImage": largeImage
      };
    } else {
      messageJs = {
        "title": title,
        "body": body,
        "payload": json.encode(toJs),
        "tag": id,
        "largImage": largeImage
      };
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
