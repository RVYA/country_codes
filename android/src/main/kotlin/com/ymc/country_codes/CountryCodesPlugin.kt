package com.ymc.country_codes

import android.R
import java.util.Locale
import androidx.annotation.NonNull;
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar


const val COUNTRY_CODES_METHOD_CHANNEL : String = "com.ymc/country_codes"
const val GET_ISO_COUNTRIES : String = "getISOCountries"
const val GET_USER_COUNTRY : String = "getUserCountry"
const val GET_USER_LANGUAGE : String = "getUserLanguage"

/** CountryCodesPlugin */
public class CountryCodesPlugin: FlutterPlugin, MethodCallHandler {
  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    val channel = MethodChannel(flutterPluginBinding.getFlutterEngine().getDartExecutor(), COUNTRY_CODES_METHOD_CHANNEL)
    channel.setMethodCallHandler(CountryCodesPlugin());
  }

  // This static function is optional and equivalent to onAttachedToEngine. It supports the old
  // pre-Flutter-1.12 Android projects. You are encouraged to continue supporting
  // plugin registration via this function while apps migrate to use the new Android APIs
  // post-flutter-1.12 via https://flutter.dev/go/android-project-migration.
  //
  // It is encouraged to share logic between onAttachedToEngine and registerWith to keep
  // them functionally equivalent. Only one of onAttachedToEngine or registerWith will be called
  // depending on the user's project. onAttachedToEngine or registerWith must both be defined
  // in the same class.
  companion object {
    @JvmStatic
    fun registerWith(registrar: Registrar) {
      val channel = MethodChannel(registrar.messenger(), COUNTRY_CODES_METHOD_CHANNEL)
      channel.setMethodCallHandler(CountryCodesPlugin())
    }
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {

    when (call.method) {
        GET_ISO_COUNTRIES -> result.success(Locale.getISOCountries().toCollection(ArrayList()))
        GET_USER_COUNTRY  -> result.success(Locale.getDefault().country)
        GET_USER_LANGUAGE -> result.success(Locale.getDefault().language)
        else -> result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) { }
}