#ifndef FLUTTER_PLUGIN_FLUTTER_MATTING_PLUGIN_H_
#define FLUTTER_PLUGIN_FLUTTER_MATTING_PLUGIN_H_

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>

#include <memory>

namespace flutter_matting {

class FlutterMattingPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  FlutterMattingPlugin();

  virtual ~FlutterMattingPlugin();

  // Disallow copy and assign.
  FlutterMattingPlugin(const FlutterMattingPlugin&) = delete;
  FlutterMattingPlugin& operator=(const FlutterMattingPlugin&) = delete;

  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

}  // namespace flutter_matting

#endif  // FLUTTER_PLUGIN_FLUTTER_MATTING_PLUGIN_H_
