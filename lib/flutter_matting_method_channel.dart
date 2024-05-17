import 'package:flutter_matting/src/messages.g.dart';

import 'flutter_matting_platform_interface.dart';

/// An implementation of [FlutterMattingPlatform] that uses method channels.
class MethodChannelFlutterMatting extends FlutterMattingPlatform {
  /// The method channel used to interact with the native platform.
  // @visibleForTesting
  // final methodChannel = const MethodChannel('flutter_matting');
  static final FlutterMattingApi _api = FlutterMattingApi();

  @override
  Future<String> cutout(String origin, String mask) async {
    return _api.cutout(origin, mask);
  }
}
