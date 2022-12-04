A library for sending notifications on Windows using Flutter

## Features

- Sending notifications by ready-made templates of the plugin
- Send notifications by user-created templates
- Receive notification events sent
- Delete all notifications sent by you from Windows Action Center
- Delete notifications group sent by you from Windows Action Center
- Add deep link to notification


## Usage

### Send notification with plugin template

Sending notifications through the plugin's own templates, there are currently 3 template available in the plugin.

```
import 'package:windows_notification/notification_message.dart';
import 'package:windows_notification/windows_notification.dart';

// Create an instance of Windows Notification with your application name
final _winNotifyPlugin = WindowsNotification(applicationId: "ASGHAR ONLINE");


// create new NotificationMessage instance with id, title, body, and images
NotificationMessage message = NotificationMessage.fromPluginTemplate(
      "test1",
      "TEXT",
      "TEXT",
      largeImage: file_path,
      image: file_path
);


// show notification    
_winNotifyPlugin.showNotificationPluginTemplate(message);

```
#### Notification with imge and large imgae

![fix2](https://user-images.githubusercontent.com/56779182/205485419-4303fdca-9f96-48e8-b6af-6f0df2ce8419.png)

#### Notification with imge

![fix3](https://user-images.githubusercontent.com/56779182/205485467-16f51b78-9dd4-4420-9de4-16c904e6871e.png)

#### notification without any image

![fix1](https://user-images.githubusercontent.com/56779182/205485486-abba6ed9-d56a-4a56-bbd5-0c7485376604.png)


### Send notification with plugin template

You can use the template made by you to send the notification
You can find a lot of templates code  with a simple search on the Internet


#### Several examples of these templates

```dart
    const String template = '''
<toast activationType="protocol">
  <visual>
    <binding template="ToastGeneric">
      <text>Weather app</text>
      <text>Expect rain today.</text>
      <group>
        <subgroup hint-weight="1" hint-textStacking="center">
          <text hint-align="center" hint-style="header">15°</text>
          <text hint-align="center" hint-style="SubtitleSubtle">Rainy</text>
        </subgroup>
        <subgroup hint-weight="1">
          <text hint-align="center">Mon</text>
          <image src="C:/Users/HP/Desktop/wallet_images/sun.jpg" hint-removeMargin="true" />
          <text hint-align="center">15°</text>
        </subgroup>
        <subgroup hint-weight="1">
          <text hint-align="center">Tue</text>
          <image src="C:/Users/HP/Desktop/wallet_images/sun.jpg" hint-removeMargin="true" />
          <text hint-align="center">17°</text>
        </subgroup>
        <subgroup hint-weight="1">
          <text hint-align="center">Wed</text>
          <image src="C:/Users/HP/Desktop/wallet_images/w.jpg" hint-removeMargin="true" />
          <text hint-align="center">21°</text>
        </subgroup>
      </group>
    </binding>
  </visual>
</toast>
''';

    NotificationMessage message =
        NotificationMessage.fromCustomTemplate("notificationid_1", group: "weather_group");
    _winNotifyPlugin.showNotificationCustomTemplate(message, template);
```

#### An image of the notification related to the above code

![weather](https://user-images.githubusercontent.com/56779182/205485702-98ed8779-483f-433b-8f00-4ca5ca130fc5.png)



```
    const String template = '''
<?xml version="1.0" encoding="utf-8"?>
<toast launch="callLaunchArg" scenario="incomingCall" activationType="protocol">
  <visual>
    <binding template="ToastGeneric">
      <text>ASGHAR CALL</text>
      <text>Incoming Call</text>
      <group>
        <subgroup hint-weight="1" hint-textStacking="center">
          <text hint-align="center" hint-style="Header">GHASEM</text>
          <image src="C:/Users/HP/Desktop/wallet_images/x.jpg" hint-crop="circle" hint-align="center" />
        </subgroup>
      </group>
    </binding>
  </visual>
  <actions>
    <action content="Text reply" imageUri="" activationType="protocol" arguments="callReply" />
    <action content="Ignore" imageUri="" activationType="protocol" arguments="callIgnore" />
    <action content="Answer" imageUri="" activationType="protocol" arguments="callAnswer" />
  </actions>
</toast>
''';

    NotificationMessage message =
        NotificationMessage.fromCustomTemplate("notificationid_1", group: "weather_group");
    _winNotifyPlugin.showNotificationCustomTemplate(message, template);
```

#### An image of the notification related to the above code

![4](https://user-images.githubusercontent.com/56779182/205485879-2ca4e45a-3209-43fa-b338-7bf30cde2ca0.png)


### Delete all notifications sent by you from Windows Action Center

```
 _winNotifyPlugin.clearNotificationHistory();
 
```
### Delete notifications group sent by you from Windows Action Center
When creating an instance of NotificationMessage , it is possible to add group to the notification

```
   _winNotifyPlugin.removeNotificationGroup("groupname");
 
```


### Delete single notification with id and group
When creating an instance of NotificationMessage , it is possible to add group and ID to the notification

```
  _winNotifyPlugin.removeNotificationId("notificationid", "groupname");
 
```

### Events and argruments
To receive your notification events, you must use the ``` initNotificationCallBack ``` method

```
   _winNotifyPlugin.initNotificationCallBack(
        (NotificationMessage data, EventType eventType, String? arguments) {});

```

### Launch option

The Launch option allows you to embed your app's deep leak into the notification, and the target user will be redirected to the relevant page by tapping on the notification.

```
NotificationMessage message = NotificationMessage.fromPluginTemplate(
  "test1", "You Win", "Tap to receive a gift",
   launch: "my-app-schame://page1");
   
_winNotifyPlugin.showNotificationPluginTemplate(message);
    
```


## Feature requests and bugs

Please file feature requests and bugs at the [issue tracker][tracker].
If you want to contribute to this library, please submit a Pull Request.

[tracker]: https://github.com/MohsenHaydari/flutter_windows_notification/issues/new
