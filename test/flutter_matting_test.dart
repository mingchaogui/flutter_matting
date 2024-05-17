import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_matting/flutter_matting.dart';
import 'package:flutter_matting/flutter_matting_platform_interface.dart';
import 'package:flutter_matting/flutter_matting_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterMattingPlatform
    with MockPlatformInterfaceMixin
    implements FlutterMattingPlatform {
  @override
  Future<String> cutout(String origin, String mask) => Future.value('result');
}

void main() {
  final FlutterMattingPlatform initialPlatform =
      FlutterMattingPlatform.instance;

  test('$MethodChannelFlutterMatting is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterMatting>());
  });

  test('cutout', () async {
    FlutterMatting flutterMattingPlugin = FlutterMatting();
    MockFlutterMattingPlatform fakePlatform = MockFlutterMattingPlatform();
    FlutterMattingPlatform.instance = fakePlatform;

    expect(await flutterMattingPlugin.cutout('origin', 'mask'), 'result');
  });
}
