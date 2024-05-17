import 'flutter_matting_platform_interface.dart';

class FlutterMatting {
  Future<String> cutout(String origin, String mask) {
    return FlutterMattingPlatform.instance.cutout(origin, mask);
  }
}
