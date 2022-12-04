#include "include/windows_notification/windows_notification_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "windows_notification_plugin.h"

void WindowsNotificationPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  windows_notification::WindowsNotificationPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
