#ifndef FLUTTER_PLUGIN_WINDOWS_NOTIFICATION_PLUGIN_H_
#define FLUTTER_PLUGIN_WINDOWS_NOTIFICATION_PLUGIN_H_

#include <windows.h>

#include <winrt/Windows.UI.Notifications.h>
#include <winrt/Windows.Data.Xml.Dom.h>
#include <winrt/Windows.foundation.h>
#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>
#include <memory>
#include <fstream>
#include <streambuf>
#include <string>
using namespace winrt;
using namespace Windows::UI::Notifications;
using namespace Windows::Data::Xml::Dom;
using namespace Windows::Foundation;
using flutter::EncodableMap;
using flutter::EncodableValue;
namespace windows_notification
{

    class WindowsNotificationPlugin : public flutter::Plugin
    {
    public:
        static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

        WindowsNotificationPlugin(std::unique_ptr<flutter::MethodChannel<>> channel);

        virtual ~WindowsNotificationPlugin();

        // Disallow copy and assign.
        WindowsNotificationPlugin(const WindowsNotificationPlugin &) = delete;
        WindowsNotificationPlugin &operator=(const WindowsNotificationPlugin &) = delete;

    private:
        void HandleMethodCall(
            const flutter::MethodCall<flutter::EncodableValue> &method_call,
            std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
        winrt::Windows::UI::Notifications::ToastNotificationManager toastManager{};
        
        std::unique_ptr<flutter::MethodChannel<>> channel_;
        

    public:
        XmlDocument showNotificaationWithImage(std::string const title, std::string const body, std::string const image, std::string const temp);
        XmlDocument showNotificaationWithoutImage(std::string const title, std::string const body, std::string const temp);
        XmlDocument showCustomTemplate(std::string const temp);
        void onActivate(Windows::UI::Notifications::ToastNotification const &notification, winrt::Windows::Foundation::IInspectable const &args);
        void onDismissed(Windows::UI::Notifications::ToastNotification const &notification, Windows::UI::Notifications::ToastDismissedEventArgs const &args);
        void clearAllNotification(std::string const appId);
        void removeNotificationTag(std::string const tag, std::string const group, std::string const appId);
        void removeNotificationGroup(std::string const group, std::string const appId);
        const EncodableValue *isNull(const EncodableMap &map, const char *key);
    };

} // namespace windows_notification

#endif // FLUTTER_PLUGIN_WINDOWS_NOTIFICATION_PLUGIN_H_
