package com.example.flutter_matting

import FlutterError
import FlutterMattingApi

import io.flutter.embedding.engine.plugins.FlutterPlugin
import kotlinx.coroutines.CoroutineExceptionHandler
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.cancel
import kotlinx.coroutines.isActive
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext

/** FlutterMattingPlugin */
class FlutterMattingPlugin: FlutterPlugin, FlutterMattingApi {
  private var pluginBinding: FlutterPlugin.FlutterPluginBinding? = null
  private var pluginScope: CoroutineScope? = null

  private val requireBinding: FlutterPlugin.FlutterPluginBinding
    get() {
      return pluginBinding ?: throw FlutterError(
        "UNAVAILABLE",
        "Plugin hasn't been attached to an engine"
      )
    }

  private val requireScope: CoroutineScope
    get() {
      return pluginScope ?: throw FlutterError(
        "UNAVAILABLE",
        "Plugin hasn't been attached to an engine"
      )
    }

  override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    pluginBinding = binding
    pluginScope = CoroutineScope(Dispatchers.Default)
    FlutterMattingApi.setUp(binding.binaryMessenger, this)
  }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    pluginBinding = null
    pluginScope?.cancel()
    pluginScope = null
    FlutterMattingApi.setUp(binding.binaryMessenger, null)
  }

  override fun cutout(origin: String, mask: String, callback: (Result<String>) -> Unit) {
    requireScope.launch(CoroutineExceptionHandler { _, throwable ->
      callback(Result.failure(throwable))
    }) {
      val originBitmap = withContext(Dispatchers.IO) {
        BitmapUtil.loadFromAssets(requireBinding, origin)
      }
      val maskBitmap = withContext(Dispatchers.IO) {
        BitmapUtil.loadFromAssets(requireBinding, mask)
      }
      val resultBitmap = originBitmap.cutout(maskBitmap)
      val resultFile = withContext(Dispatchers.IO) {
        resultBitmap.saveToFile(
          requireBinding.applicationContext.cacheDir.path,
          "result"
        )
      }

      if (!isActive) {
        throw IllegalStateException("Coroutine scope has been canceled")
      }

      callback(Result.success(resultFile.path))
    }
  }
}
