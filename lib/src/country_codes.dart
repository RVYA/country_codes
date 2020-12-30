import 'dart:async';
import 'dart:ui' show Locale;

import 'package:flutter/foundation.dart' show required;
import 'package:flutter/services.dart';

part 'dial_codes.dart';


const Locale _kDefaultLocale = const Locale("en", "US");
const String
  _kCountryCodesMethodChannel = "com.ymc/country_codes",
  _kGetISOCountries = "getISOCountries",
  _kGetUserCountry  =  "getUserCountry",
  _kGetUserLanguage = "getUserLanguage";


class CountryCodes {
  static const MethodChannel
      _channel = const MethodChannel(_kCountryCodesMethodChannel);
  
  static Locale _deviceLocale;
  static Locale get deviceLocale {
    assert(
      _deviceLocale != null,
      "Please make sure you initialized this class properly.",
    );
    return _deviceLocale;
  }

  static List<String> _iso3166CountryCodes;
  static List<String> get iso3166CountryCodes {
    assert(
      (_iso3166CountryCodes != null) && (_iso3166CountryCodes.isNotEmpty),
      "Please make sure you initialized this class properly.",
    );
    return _iso3166CountryCodes;
  }


  static Future<bool> init() async {
    final String
      userCountry = await _channel.invokeMethod<String>(_kGetUserCountry),
      userLanguage = await _channel.invokeMethod<String>(_kGetUserLanguage);

    _deviceLocale = (userCountry != null && userLanguage != null)?
                      Locale(userLanguage, userCountry) : _kDefaultLocale;

    _iso3166CountryCodes = await _channel
                                  .invokeListMethod<String>(_kGetISOCountries);
    
    return (_deviceLocale != null) && (_iso3166CountryCodes != null);
  }

  static String dialCode({@required String countryCode}) {
    return kCountryDialCodes[countryCode];
  }
}
