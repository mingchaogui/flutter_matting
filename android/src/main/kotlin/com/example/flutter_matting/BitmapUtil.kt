package com.example.flutter_matting

import android.graphics.Bitmap
import android.graphics.BitmapFactory
import io.flutter.embedding.engine.plugins.FlutterPlugin

object BitmapUtil {
    fun  loadFromAssets(binding: FlutterPlugin.FlutterPluginBinding, assetName: String): Bitmap {
        val path = binding.flutterAssets.getAssetFilePathByName(assetName)
        val inputStream = binding.applicationContext.assets.open(path)
        return inputStream.use {
            BitmapFactory.decodeStream(it)
        }
    }
}