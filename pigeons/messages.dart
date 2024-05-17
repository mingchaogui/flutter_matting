import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages.g.dart',
  swiftOut: 'ios/Classes/Messages.g.swift',
  swiftOptions: SwiftOptions(),
  kotlinOut:
      'android/src/main/kotlin/com/example/flutter_matting/Messages.g.kt',
  kotlinOptions: KotlinOptions(),
))
@HostApi()
abstract class FlutterMattingApi {
  @async
  String cutout(String origin, String mask);
}
