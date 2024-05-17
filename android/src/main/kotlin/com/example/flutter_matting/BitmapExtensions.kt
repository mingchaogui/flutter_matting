package com.example.flutter_matting

import android.graphics.Bitmap
import android.graphics.Color
import android.os.Build
import java.io.File
import java.io.FileOutputStream

fun Bitmap.cutout(mask: Bitmap): Bitmap {
    if (width != mask.width || height != mask.height) {
        throw IllegalArgumentException("The sizes of the 'origin' and the 'mask' do not match.")
    }

    val result = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888)

    for (y in 0 until height) {
        for (x in 0 until width) {
            val maskPixel = mask.getPixel(x, y)

            // 如果mask上像素是黑色，则不保留origin对应像素的颜色
            if (maskPixel != Color.BLACK) {
                val originPixel = getPixel(x, y)
                result.setPixel(x, y, originPixel)
            }
        }
    }

    return result
}

fun Bitmap.saveToFile(dirName: String, basename: String): File {
    val filename = dirName + File.pathSeparator + basename + ".webp"
    val file = File(filename)
    FileOutputStream(file).use {
        val format = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
            Bitmap.CompressFormat.WEBP_LOSSLESS
        } else {
            Bitmap.CompressFormat.WEBP
        }
        val success = compress(format, 100, it)
        if (!success) {
            throw UnknownError("Failed to compress the bitmap.")
        }
    }
    return file
}