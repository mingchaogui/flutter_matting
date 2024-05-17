//
//  UIImageExtensionsExtensions.swift
//  flutter_matting
//
//  Created by Hito on 2024/5/17.
//

import Foundation

extension UIImage {
    public func cutout(mask: UIImage) throws -> UIImage? {
        if (self.size != mask.size) {
            throw PigeonError(code: "=_=", message: "The sizes of the 'origin' and the 'mask' do not match.", details: nil)
        }

        guard let cgImage = self.cgImage, let maskCgImage = mask.cgImage else {
            return nil
        }

        let width = Int(self.size.width)
        let height = Int(self.size.height)
        let bitsPerComponent = 8
        let bytesPerRow = 4 * width
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)

        // Draw the original image
        guard let context = CGContext(data: nil, width: width, height: height, bitsPerComponent: bitsPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        guard let imageData = context.data else { return nil }

        // Draw the mask image
        guard let maskContext = CGContext(data: nil, width: width, height: height,
                                          bitsPerComponent: 8, bytesPerRow: 4 * width,
                                          space: colorSpace, bitmapInfo: bitmapInfo.rawValue) else {
            return nil
        }
        maskContext.draw(maskCgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        guard let maskImageData = maskContext.data else { return nil }

        let imagePtr = imageData.bindMemory(to: UInt8.self, capacity: width * height * 4)
        let maskPtr = maskImageData.bindMemory(to: UInt8.self, capacity: width * height * 4)

        for y in 0..<height {
            for x in 0..<width {
                let pixelIndex = (y * width + x) * 4
                let maskPixel = maskPtr[pixelIndex]

                // If mask pixel is black (R, G, B values are all 0), set the original image pixel to transparent
                if maskPixel == 0 {
                    // Set alpha to 0
                    imagePtr[pixelIndex + 3] = 0
                }
            }
        }

        guard let resultImage = context.makeImage() else { return nil }
        return UIImage(cgImage: resultImage)
    }

    public func saveToFile(url: URL, basename: String) throws -> URL {
        let toUrl = url.appendingPathComponent(basename + ".png")
        try pngData()!.write(to: toUrl)
        return toUrl
    }
}
