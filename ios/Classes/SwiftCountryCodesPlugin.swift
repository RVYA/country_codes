import Flutter
import UIKit


public class SwiftCountryCodesPlugin: NSObject, FlutterPlugin {
  let countryCodesMethodChannel = "com.ymc/country_codes";
  let getISOCountries = "getISOCountries";
  let getUserCountry  =  "getUserCountry";
  let getUserLanguage = "getUserLanguage";

  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: countryCodesMethodChannel, binaryMessenger: registrar.messenger())
    let instance = SwiftCountryCodesPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
      case getISOCountries:
          result(NSLocale.isoCountryCodes)
          break
      case getUserCountry:
          result(Locale.current.regionCode)
          break
      case getUserLanguage:
          result(Locale.current.languageCode)
          break
      default:
          result(FlutterMethodNotImplemented);
    }
  }
}
