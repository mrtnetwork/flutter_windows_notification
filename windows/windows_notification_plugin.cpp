#include "windows_notification_plugin.h"

namespace windows_notification
{

  // static
  void WindowsNotificationPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarWindows *registrar)
  {
    auto channel =
        std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
            registrar->messenger(), "windows_notification",
            &flutter::StandardMethodCodec::GetInstance());
    auto *channel_pointer = channel.get();
    auto plugin = std::make_unique<WindowsNotificationPlugin>(std::move(channel));

    channel_pointer->SetMethodCallHandler(
        [plugin_pointer = plugin.get()](const auto &call, auto result)
        {
          plugin_pointer->HandleMethodCall(call, std::move(result));
        });

    registrar->AddPlugin(std::move(plugin));
  }

  WindowsNotificationPlugin::WindowsNotificationPlugin(std::unique_ptr<flutter::MethodChannel<>> channel)
  {
    channel_ = std::move(channel);
  }

  WindowsNotificationPlugin::~WindowsNotificationPlugin()
  {
  }

  void WindowsNotificationPlugin::HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result)
  {
    try
    {
      if (method_call.method_name().compare("show_notification_image") == 0)
      {
        auto args = std::get<flutter::EncodableMap>(*method_call.arguments());
        std::string const title = std::get<std::string>(args[flutter::EncodableValue("title")]);
        std::string const tag = std::get<std::string>(args[flutter::EncodableValue("tag")]);
        std::string const body = std::get<std::string>(args[flutter::EncodableValue("body")]);
        std::string const image = std::get<std::string>(args[flutter::EncodableValue("image")]);
        std::string const payload = std::get<std::string>(args[flutter::EncodableValue("payload")]);
        std::string const temp = std::get<std::string>(args[flutter::EncodableValue("template")]);
        XmlDocument doc = showNotificaationWithImage(title, body, image, temp);
        doc.DocumentElement().SetAttribute(L"payload", winrt::to_hstring(payload));
        auto value = isNull(args, "launch");
        if (value)
        {
          std::string const launchData = std::get<std::string>(args[flutter::EncodableValue("launch")]);
          doc.DocumentElement().SetAttribute(L"launch", winrt::to_hstring(launchData));
        }
        ToastNotification notif{doc};
        
        notif.Activated({this, &WindowsNotificationPlugin::onActivate});
        notif.Dismissed({this, &WindowsNotificationPlugin::onDismissed});

        notif.Tag(winrt::to_hstring(tag));
        auto groupExist = isNull(args, "group");
        if (groupExist)
        {
          std::string const group = std::get<std::string>(args[flutter::EncodableValue("group")]);
          notif.Group(winrt::to_hstring(group));
        }

        auto withAppId = isNull(args, "application_id");
        if (withAppId)
        {
          std::string const appId = std::get<std::string>(args[flutter::EncodableValue("application_id")]);
          ToastNotifier toastNotifier_{toastManager.CreateToastNotifier(winrt::to_hstring(appId))};
          toastNotifier_.Show(notif);
        }
        else
        {
          ToastNotifier toastNotifier_{toastManager.CreateToastNotifier()};
          toastNotifier_.Show(notif);
        }
        result->Success(nullptr);
      }
      else if (method_call.method_name().compare("custom_template") == 0)
      {
        auto args = std::get<flutter::EncodableMap>(*method_call.arguments());
        std::string const tag = std::get<std::string>(args[flutter::EncodableValue("tag")]);
        std::string const payload = std::get<std::string>(args[flutter::EncodableValue("payload")]);
        std::string const temp = std::get<std::string>(args[flutter::EncodableValue("template")]);
        XmlDocument doc = showCustomTemplate(temp);
        doc.DocumentElement().SetAttribute(L"payload", winrt::to_hstring(payload));
        auto value = isNull(args, "launch");
        if (value)
        {
          std::string const launchData = std::get<std::string>(args[flutter::EncodableValue("launch")]);
          doc.DocumentElement().SetAttribute(L"launch", winrt::to_hstring(launchData));
        }
        ToastNotification notif{doc};

        notif.Tag(winrt::to_hstring(tag));
        auto groupExist = isNull(args, "group");
        if (groupExist)
        {
          std::string const group = std::get<std::string>(args[flutter::EncodableValue("group")]);
          notif.Group(winrt::to_hstring(group));
        }
        auto withAppId = isNull(args, "application_id");
        if (withAppId)
        {
          std::string const appId = std::get<std::string>(args[flutter::EncodableValue("application_id")]);
          ToastNotifier toastNotifier_{toastManager.CreateToastNotifier(winrt::to_hstring(appId))};
          toastNotifier_.Show(notif);
        }
        else
        {
          ToastNotifier toastNotifier_{toastManager.CreateToastNotifier()};
          toastNotifier_.Show(notif);
        }
        notif.Activated({this, &WindowsNotificationPlugin::onActivate});
        notif.Dismissed({this, &WindowsNotificationPlugin::onDismissed});
        // test(t);
        result->Success(nullptr);
      }
      else if (method_call.method_name().compare("show_notification") == 0)
      {
        auto args = std::get<flutter::EncodableMap>(*method_call.arguments());
        std::string const title = std::get<std::string>(args[flutter::EncodableValue("title")]);
        std::string const tag = std::get<std::string>(args[flutter::EncodableValue("tag")]);
        std::string const body = std::get<std::string>(args[flutter::EncodableValue("body")]);
        std::string const payload = std::get<std::string>(args[flutter::EncodableValue("payload")]);
        std::string const temp = std::get<std::string>(args[flutter::EncodableValue("template")]);
        XmlDocument doc = showNotificaationWithoutImage(title, body, temp);
        doc.DocumentElement().SetAttribute(L"payload", winrt::to_hstring(payload));
        auto value = isNull(args, "launch");
        if (value)
        {
          std::string const launchData = std::get<std::string>(args[flutter::EncodableValue("launch")]);
          doc.DocumentElement().SetAttribute(L"launch", winrt::to_hstring(launchData));
        }
        ToastNotification notif{doc};
        notif.Activated({this, &WindowsNotificationPlugin::onActivate});
        notif.Dismissed({this, &WindowsNotificationPlugin::onDismissed});
        notif.Tag(winrt::to_hstring(tag));
        auto groupExist = isNull(args, "group");
        if (groupExist)
        {
          std::string const group = std::get<std::string>(args[flutter::EncodableValue("group")]);
          notif.Group(winrt::to_hstring(group));
        }
        auto withAppId = isNull(args, "application_id");
        if (withAppId)
        {
          std::string const appId = std::get<std::string>(args[flutter::EncodableValue("application_id")]);
          ToastNotifier toastNotifier_{toastManager.CreateToastNotifier(winrt::to_hstring(appId))};
          toastNotifier_.Show(notif);
        }
        else
        {
          ToastNotifier toastNotifier_{toastManager.CreateToastNotifier()};
          toastNotifier_.Show(notif);
        }

        // test(t);
        result->Success(nullptr);
      }
      else if (method_call.method_name().compare("clear_history") == 0)
      {
        auto args = std::get<flutter::EncodableMap>(*method_call.arguments());
        auto withAppId = isNull(args, "application_id");
        if (withAppId)
        {
          std::string const appId = std::get<std::string>(args[flutter::EncodableValue("application_id")]);
          clearAllNotification(appId);
        }
        else
        {
          toastManager.History().Clear();
        }
        result->Success(nullptr);
      }
      else if (method_call.method_name().compare("remove_notification") == 0)
      {
        auto args = std::get<flutter::EncodableMap>(*method_call.arguments());
        std::string const tag = std::get<std::string>(args[flutter::EncodableValue("tag")]);
        std::string const group = std::get<std::string>(args[flutter::EncodableValue("group")]);

        auto withAppId = isNull(args, "application_id");
        if (withAppId)
        {
          std::string const appId = std::get<std::string>(args[flutter::EncodableValue("application_id")]);
          removeNotificationTag(tag, group, appId);
        }
        else
        {
          toastManager.History().Remove(winrt::to_hstring(tag), winrt::to_hstring(group));
        }

        result->Success(nullptr);
      }
      else if (method_call.method_name().compare("remove_group") == 0)
      {

        auto args = std::get<flutter::EncodableMap>(*method_call.arguments());
        std::string const group = std::get<std::string>(args[flutter::EncodableValue("group")]);
        auto withAppId = isNull(args, "application_id");
        if (withAppId)
        {
          std::string const appId = std::get<std::string>(args[flutter::EncodableValue("application_id")]);
          removeNotificationGroup(group, appId);
        }
        else
        {
          toastManager.History().RemoveGroup(winrt::to_hstring(group));
        }

        result->Success(nullptr);
      }
      else
      {
        result->NotImplemented();
      }
    }
    catch (const std::exception &e)
    {
      std::cerr << e.what() << '\n';
      result->Success(nullptr);
    }
  }

  XmlDocument WindowsNotificationPlugin::showNotificaationWithImage(std::string const title, std::string const body, std::string const image, std::string const temp)
  {
    XmlDocument doc; // ToastNotificationManager::GetTemplateContent(ToastTemplateType::ToastImageAndText02);
    doc.LoadXml(winrt::to_hstring(temp));
    doc.SelectSingleNode(L"//text[1]").InnerText(winrt::to_hstring(title));
    doc.SelectSingleNode(L"//text[2]").InnerText(winrt::to_hstring(body));
    doc.SelectSingleNode(L"//image[1]").as<XmlElement>().SetAttribute(L"src", winrt::to_hstring(image));
    return doc;
  }
  XmlDocument WindowsNotificationPlugin::showCustomTemplate(std::string const temp)
  {
    XmlDocument doc; // ToastNotificationManager::GetTemplateContent(ToastTemplateType::ToastImageAndText02);
    doc.LoadXml(winrt::to_hstring(temp));
    return doc;
  }
  XmlDocument WindowsNotificationPlugin::showNotificaationWithoutImage(std::string const title, std::string const body, std::string const temp)
  {

    XmlDocument doc; // ToastNotificationManager::GetTemplateContent(ToastTemplateType::ToastImageAndText02);
    doc.LoadXml(winrt::to_hstring(temp));
    doc.SelectSingleNode(L"//text[1]").InnerText(winrt::to_hstring(title));

    doc.SelectSingleNode(L"//text[2]").InnerText(winrt::to_hstring(body));
    return doc;
  }

  void WindowsNotificationPlugin::onActivate(Windows::UI::Notifications::ToastNotification const &notification, winrt::Windows::Foundation::IInspectable const &args)
  {

    XmlDocument const doc = notification.Content();
    winrt::hstring payload = doc.DocumentElement().GetAttribute(L"payload");
    ToastActivatedEventArgs ar = args.as<ToastActivatedEventArgs>();
    Collections::ValueSet userInput = ar.UserInput();

    EncodableMap notificationArgruments;
    notificationArgruments[EncodableValue("launch")] = EncodableValue(winrt::to_string(payload));
    notificationArgruments[EncodableValue("arguments")] = EncodableValue(winrt::to_string(ar.Arguments()));
    EncodableMap userInputArgruments;
    auto iterable = userInput.GetView();
    for (auto const& pair : iterable)
    {
        winrt::hstring key = pair.Key();
        IInspectable value = pair.Value();
        auto keyStr = winrt::to_string(key);
        auto hstr = value.as<winrt::Windows::Foundation::IStringable>();
        std::string valueStr = winrt::to_string(hstr.ToString());
        userInputArgruments[EncodableValue(keyStr)] = EncodableValue(valueStr);
        
    }
    notificationArgruments[EncodableValue("user_input")]=EncodableValue(userInputArgruments);
    EncodableValue res = EncodableValue(notificationArgruments);
    channel_->InvokeMethod("onActivate", std::make_unique<flutter::EncodableValue>(res));
  }
  void WindowsNotificationPlugin::onDismissed(Windows::UI::Notifications::ToastNotification const &notification, winrt::Windows::UI::Notifications::ToastDismissedEventArgs const &args)
  {
    auto reason = args.Reason();
    XmlDocument const doc = notification.Content();
    winrt::hstring payload = doc.DocumentElement().GetAttribute(L"payload");
    std::string methodName;
    EncodableValue res = EncodableValue(EncodableMap{
        {EncodableValue("launch"), EncodableValue(winrt::to_string(payload))},
    });
          switch (reason)
    {
        case Windows::UI::Notifications::ToastDismissalReason::ApplicationHidden:
            methodName = "onDismissedApplicationHidden";
            break;
        case Windows::UI::Notifications::ToastDismissalReason::UserCanceled:
            methodName = "onDismissedUserCanceled";
            break;
        default:
            methodName = "onDismissedTimedOut";
            break;
    }
    channel_->InvokeMethod(methodName, std::make_unique<flutter::EncodableValue>(res));
  };

  void WindowsNotificationPlugin::clearAllNotification(std::string const appId)
  {
    toastManager.History().Clear(winrt::to_hstring(appId));
  };

  void WindowsNotificationPlugin::removeNotificationTag(std::string const tag, std::string const group, std::string const appId)
  {
    toastManager.History().Remove(winrt::to_hstring(tag), winrt::to_hstring(group), winrt::to_hstring(appId));
  }
  void WindowsNotificationPlugin::removeNotificationGroup(std::string const group, std::string const appId)
  {
    toastManager.History().RemoveGroup(winrt::to_hstring(group), winrt::to_hstring(appId));
  }
  const EncodableValue *WindowsNotificationPlugin::isNull(const EncodableMap &map, const char *key)
  {
    auto it = map.find(EncodableValue(key));
    if (it == map.end())
    {
      return nullptr;
    }
    return &(it->second);
  }

} // namespace windows_notification
