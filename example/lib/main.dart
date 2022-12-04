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
  final _winNotifyPlugin = WindowsNotification(applicationId: "ASGHAR ONLINE");

  @override
  void initState() {
    _winNotifyPlugin.initNotificationCallBack((data, s, d) {});
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
<toast activationType="protocol">
  <visual>
    <binding template="ToastGeneric">
      <text id="1">Today's plan</text>
         <text id="2">Our plan today is traveling to the moon</text>
          <image placement="appLogoOverride" hint-crop="circle" id="1" src='C:/Users/HP/Desktop/wallet_images/x.jpg'/>
          <image src='C:/Users/HP/Desktop/wallet_images/x3.jpg'/>
    </binding>
  </visual>
</toast>
''';
    NotificationMessage message =
        NotificationMessage.fromCustomTemplate("test1", group: "jj");
    _winNotifyPlugin.showNotificationCustomTemplate(message, template);
    // _winNotifyPlugin.removeNotificationGroup("jafa222r");
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
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    sendMyOwnTemplate();
                  },
                  child: Text("Send custom notification")),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    sendWithPluginTemplate();
                  },
                  child: Text("Send plugin notification")),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    _winNotifyPlugin.clearNotificationHistory();
                  },
                  child: Text("Clear action center notification")),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    _winNotifyPlugin.removeNotificationGroup("jj");
                  },
                  child: Text("Clear group notification")),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  onPressed: () {
                    _winNotifyPlugin.removeNotificationId("test1", "jj");
                  },
                  child: Text("Remove single notification")),
            ],
          ),
        ),
      ),
    );
  }
}
