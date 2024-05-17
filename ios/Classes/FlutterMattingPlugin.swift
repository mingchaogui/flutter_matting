import Flutter
import UIKit

public class FlutterMattingPlugin: NSObject, FlutterPlugin, FlutterMattingApi {
    private static var registrar: FlutterPluginRegistrar?
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
        let messenger : FlutterBinaryMessenger = registrar.messenger()
        let api : FlutterMattingApi & NSObjectProtocol = FlutterMattingPlugin.init()
        FlutterMattingApiSetup.setUp(binaryMessenger: messenger, api: api)
    }
    
    public func cutout(origin: String, mask: String, completion: @escaping (Result<String, any Error>) -> Void) {
        DispatchQueue.global(qos: .default).async {
            do {
                let originImage = try UIImageUtil.loadFromAssets(registrar: FlutterMattingPlugin.registrar!, assetName: origin)
                let maskImage = try UIImageUtil.loadFromAssets(registrar: FlutterMattingPlugin.registrar!, assetName: mask)
                guard let resultImage = try originImage.cutout(mask: maskImage) else {
                    throw PigeonError(code: "=_=", message: "Something went wrong...", details: nil)
                }
                let resultUrl = try resultImage.saveToFile(url: FileManager.default.temporaryDirectory, basename: "result")

                completion(.success(resultUrl.path))
            } catch {
                completion(.failure(PigeonError(code: "UNAVAILABLE", message: error.localizedDescription, details: String(describing: error))))
            }
        }
    }
}
