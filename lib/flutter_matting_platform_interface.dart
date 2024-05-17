import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_matting_method_channel.dart';

abstract class FlutterMattingPlatform extends PlatformInterface {
  /// Constructs a FlutterMattingPlatform.
  FlutterMattingPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterMattingPlatform _instance = MethodChannelFlutterMatting();

  /// The default instance of [FlutterMattingPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterMatting].
  static FlutterMattingPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterMattingPlatform] when
  /// they register themselves.
  static set instance(FlutterMattingPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> cutout(String origin, String mask) {
    throw UnimplementedError('cutout() has not been implemented.');
  }
}
