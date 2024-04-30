#ifndef FLUTTER_PLUGIN_WINDOWS_NOTIFICATION_PLUGIN_H_
#define FLUTTER_PLUGIN_WINDOWS_NOTIFICATION_PLUGIN_H_
#include <winrt/Windows.foundation.h>
#include <winrt/Windows.Foundation.Collections.h>
#include <windows.h>
#include <winrt/Windows.UI.Notifications.h>
#include <winrt/Windows.Data.Xml.Dom.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/basic_message_channel.h>
#include <flutter/standard_method_codec.h>
#include <flutter/method_call.h>
#include <flutter/method_codec.h>
#include <winrt/Windows.UI.Core.h>
#include <memory>
#include <fstream>
#include <streambuf>
#include <string>

using namespace winrt::Windows::UI::Core;
using namespace winrt;
using namespace Windows::UI::Notifications;
using namespace Windows::Data::Xml::Dom;
using namespace Windows::Foundation;
using flutter::EncodableMap;
using flutter::EncodableValue;
using flutter::BasicMessageChannel;
namespace windows_notification
{

    class WindowsNotificationPlugin : public flutter::Plugin
    {
    public:
        static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

        // WindowsNotificationPlugin(std::unique_ptr<flutter::MethodChannel<>> channel);
        WindowsNotificationPlugin(flutter::PluginRegistrarWindows* registrar);
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
        flutter::PluginRegistrarWindows* registrar;
        HWND current_window;
        const flutter::StandardMethodCodec* codec_;

    public:
        XmlDocument showNotificaationWithImage(std::string const title, std::string const body, std::string const image, std::string const temp);
        XmlDocument showNotificaationWithoutImage(std::string const title, std::string const body, std::string const temp);
        XmlDocument showCustomTemplate(std::string const temp);
        void onActivate(Windows::UI::Notifications::ToastNotification const &notification, winrt::Windows::Foundation::IInspectable const &args);
        void onDismissed(Windows::UI::Notifications::ToastNotification const &notification, Windows::UI::Notifications::ToastDismissedEventArgs const &args);
        void clearAllNotification(std::string const appId);
        void init();
        void removeNotificationTag(std::string const tag, std::string const group, std::string const appId);
        void removeNotificationGroup(std::string const group, std::string const appId);
        void sendToMainThread(std::string methodName,EncodableValue value);
        void handleBackgroundMessage(LPARAM lParam);
        const EncodableValue *isNull(const EncodableMap &map, const char *key);
        std::optional<LRESULT> WProc(HWND hWnd, UINT message,WPARAM wParam,LPARAM lParam);
        int proc_id = -1;
        HWND GetWindow();
        const UINT NotificationThreadMessageId = static_cast<const UINT>(22222);
        
    };

} // namespace windows_notification

#endif // FLUTTER_PLUGIN_WINDOWS_NOTIFICATION_PLUGIN_H_
