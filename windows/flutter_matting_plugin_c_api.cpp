#include "include/flutter_matting/flutter_matting_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "flutter_matting_plugin.h"

void FlutterMattingPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  flutter_matting::FlutterMattingPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
