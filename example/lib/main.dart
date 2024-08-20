// ignore_for_file: avoid_print

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';
import 'package:example/templates/alarm_template.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:example/templates/meeting_template.dart';

void main() {
  runApp(const MaterialApp(
    home: MyApp(),
    color: Colors.red,
    themeMode: ThemeMode.light,
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<String> getImageBytes(String url) async {
    final supportDir = await getApplicationSupportDirectory();
    final cl = http.Client();
    final resp = await cl.get(Uri.parse(url));
    final bytes = resp.bodyBytes;
    final imageFile =
        File("${supportDir.path}/${DateTime.now().millisecond}.png");
    await imageFile.create();
    await imageFile.writeAsBytes(bytes);
    return imageFile.path;
  }

  void showWithLargeImage() async {
    const String url =
        "https://user-images.githubusercontent.com/56779182/205485419-4303fdca-9f96-48e8-b6af-6f0df2ce8419.png";

    final imageDir = await getImageBytes(url);

    NotificationMessage message = NotificationMessage.fromPluginTemplate(
      "moon",
      "fly to the moon",
      "we are ready!",
      largeImage: imageDir,
      launch: "https://en.wikipedia.org/wiki/Japanese_language",
    );
    _winNotifyPlugin.showNotificationPluginTemplate(message);
  }

  void showWithSmallImage() async {
    const String url =
        "https://www.wikipedia.org/portal/wikipedia.org/assets/img/Wikipedia-logo-v2@1.5x.png";

    final imageDir = await getImageBytes(url);

    NotificationMessage message = NotificationMessage.fromPluginTemplate(
        "Japanese language", "Japanese language", "how to read",
        image: imageDir,
        launch: "https://en.wikipedia.org/wiki/Japanese_language");
    _winNotifyPlugin.showNotificationPluginTemplate(message);
  }

  void showWithLargeAndSmalImage() async {
    const String url =
        "https://www.wikipedia.org/portal/wikipedia.org/assets/img/Wikipedia-logo-v2@1.5x.png";

    final imageDir = await getImageBytes(url);

    NotificationMessage message = NotificationMessage.fromPluginTemplate(
        "Japanese language", "Japanese language", "how to read",
        image: imageDir,
        launch: "https://en.wikipedia.org/wiki/Japanese_language",
        largeImage: imageDir);
    _winNotifyPlugin.showNotificationPluginTemplate(message);
  }

  void showAlarm() {
    NotificationMessage message =
        NotificationMessage.fromCustomTemplate("test1", group: "jj");
    _winNotifyPlugin.showNotificationCustomTemplate(message, alarmtTemplate);
  }

  void showMeetingTemplate() {
    NotificationMessage message =
        NotificationMessage.fromCustomTemplate("test1", group: "jj");
    _winNotifyPlugin.showNotificationCustomTemplate(message, meetingTemplate);
  }

  final _winNotifyPlugin = WindowsNotification(
      applicationId:
          r"{D65231B0-B2F1-4857-A4CE-A8E7C6EA7D27}\WindowsPowerShell\v1.0\powershell.exe");

  @override
  void initState() {
    _winNotifyPlugin.initNotificationCallBack((s) {
      print(s.argrument);
      print(s.userInput);
      print(s.eventType);
    });
    super.initState();
  }

  void sendWithPluginTemplate() {
    NotificationMessage message = NotificationMessage.fromPluginTemplate(
        "test1", "TEXT", "TEXT",
        image: r"C:\in_work\mrt_logo\large.png",
        payload: {"action": "open_center"});
    _winNotifyPlugin.showNotificationPluginTemplate(message);
  }

  void sendMyOwnTemplate() {
    /// image tag src must be set
    /// for actions make sure your argruments contains `:` like "action:open_center"
    const String template = '''
<?xml version="1.0" encoding="utf-8"?>
  <toast launch='conversationId=9813' activationType="background">
    <visual>
        <binding template='ToastGeneric'>
            <text>Some text</text>
        </binding>
    </visual>
    <actions>
        <action content='Archive'  arguments='action:archive'/>
    </actions>
</toast>
''';

    NotificationMessage message =
        NotificationMessage.fromCustomTemplate("test1", group: "jj");
    _winNotifyPlugin.showNotificationCustomTemplate(message, template);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(25),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            onPressed: () {
                              sendMyOwnTemplate();
                            },
                            child: const Text(
                                "Send simple notification with custom template and simple action")),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              sendWithPluginTemplate();
                            },
                            child: const Text(
                                "Send Simple notification with title body and small image")),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _winNotifyPlugin.clearNotificationHistory();
                            },
                            child:
                                const Text("Clear action center notification")),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _winNotifyPlugin.removeNotificationGroup("jj");
                            },
                            child: const Text("Clear group notification")),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              _winNotifyPlugin.removeNotificationId(
                                  "test1", "jj");
                            },
                            child: const Text("Remove single notification")),
                        const SizedBox(height: 8),
                        ElevatedButton(
                            onPressed: () {
                              showAlarm();
                            },
                            child: const Text(
                                "show alarm with custom temolate userInputs and action")),
                        const SizedBox(height: 8),
                        ElevatedButton(
                            onPressed: () {
                              showWithLargeImage();
                            },
                            child: const Text(
                                "show with large image and lunch uri")),
                        const SizedBox(height: 8),
                        ElevatedButton(
                            onPressed: () {
                              showWithSmallImage();
                            },
                            child: const Text(
                                "show with small image and lunch uri")),
                        const SizedBox(height: 8),
                        ElevatedButton(
                            onPressed: () {
                              showWithLargeAndSmalImage();
                            },
                            child: const Text(
                                "show with large and small image and lunch uri")),
                        const SizedBox(height: 8),
                        ElevatedButton(
                            onPressed: () {
                              showMeetingTemplate();
                            },
                            child: const Text(
                                "meeting temolate with action and inputs")),
                      ],
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
