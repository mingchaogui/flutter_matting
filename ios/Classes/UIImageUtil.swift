//
//  BitmapUtil.swift
//  flutter_matting
//
//  Created by Hito on 2024/5/17.
//

import Flutter
import Foundation

class UIImageUtil {
    public static func loadFromAssets(
        registrar: FlutterPluginRegistrar,
        assetName: String
    ) throws -> UIImage {
        let key = registrar.lookupKey(forAsset: assetName)
        guard let path = Bundle.main.path(forResource: key, ofType: nil) else {
            throw PigeonError(code: "=_=", message: "Failed to lookup resource", details: nil)
        }
        guard let image = UIImage(contentsOfFile: path) else {
            throw PigeonError(code: "=_=", message: "Failed to load image", details: nil)
        }
        return image
    }
}
