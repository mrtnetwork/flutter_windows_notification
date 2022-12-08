import 'package:flutter/material.dart';
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

void main() {
  runApp(MaterialApp(
    home: const MyApp(),
    color: Colors.red,
    themeMode: ThemeMode.light,
    theme: ThemeData(
        backgroundColor: Colors.red,
        primaryColor: Colors.red,
        primarySwatch: Colors.red),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _winNotifyPlugin = WindowsNotification(
      applicationId:
          r"{D65231B0-B2F1-4857-A4CE-A8E7C6EA7D27}\WindowsPowerShell\v1.0\powershell.exe");

  @override
  void initState() {
    // final _winNotifyPlugin = WindowsNotification(applicationId: "qweqwe");
    _winNotifyPlugin.initNotificationCallBack((notification, status, argruments) {
      print("aargs: $argruments");
    });
    super.initState();
  }

  sendWithPluginTemplate() {
    NotificationMessage message = NotificationMessage.fromPluginTemplate(
      "test1",
      "TEXT",
      "TEXT",
    );
    _winNotifyPlugin.showNotificationPluginTemplate(message);
  }

  sendMyOwnTemplate() {
    // image tag src must be set
    const String template = '''
<?xml version="1.0" encoding="utf-8"?>
  <toast launch='conversationId=9813' activationType="background">
    <visual>
        <binding template='ToastGeneric'>
            <text>Some text</text>
        </binding>
    </visual>
    <actions>
        <action content='Archive'  arguments='action=archive'/>
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
        backgroundColor: Theme.of(context).backgroundColor,
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {}, label: const Icon(Icons.send)),
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    sendMyOwnTemplate();
                  },
                  child: const Text("Send custom notification")),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    sendWithPluginTemplate();
                  },
                  child: const Text("Send plugin notification")),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    _winNotifyPlugin.clearNotificationHistory();
                  },
                  child: const Text("Clear action center notification")),
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
                    _winNotifyPlugin.removeNotificationId("test1", "jj");
                  },
                  child: const Text("Remove single notification")),
            ],
          ),
        ),
      ),
    );
  }
}
