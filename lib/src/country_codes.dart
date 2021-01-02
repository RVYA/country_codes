import 'dart:async';
import 'dart:ui' show Locale;

import 'package:flutter/foundation.dart' show required;
import 'package:flutter/services.dart';


part 'iso_country_codes.dart';
part 'iso_dial_codes.dart';


const Locale _kDefaultLocale = const Locale("en", "US");
const String
  _kCountryCodesMethodChannel = "com.ymc/country_codes",
  _kGetUserCountry  =  "getUserCountry",
  _kGetUserLanguage = "getUserLanguage";

// TODO: Consider using Set<String> as the collection. Code needs a few performance tests.
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

  static List<String> _isoAlpha2CountryCodes;
  static List<String> get isoAlpha2CountryCodes {
    assert(
      (_isoAlpha2CountryCodes != null) && (_isoAlpha2CountryCodes.isNotEmpty),
      "Please make sure you initialized this class properly.",
    );
    return _isoAlpha2CountryCodes;
  }

  static List<String> _isoCountryNames;
  static List<String> get isoCountryNames {
    assert(
      (_isoCountryNames != null) && (_isoCountryNames.isNotEmpty),
      "Please make sure you initialized this class properly.",
    );
    return _isoCountryNames;
  }


  static Future<bool> init() async {
    final String
      userCountry = await _channel.invokeMethod<String>(_kGetUserCountry),
      userLanguage = await _channel.invokeMethod<String>(_kGetUserLanguage);

    _deviceLocale = (userCountry != null && userLanguage != null)?
                      Locale(userLanguage, userCountry) : _kDefaultLocale;

    _isoAlpha2CountryCodes = kISOCountryCodes.values.toList(growable: false);
    _isoCountryNames = kISOCountryCodes.keys.toList(growable: false);

    return (_deviceLocale != null) && (_isoAlpha2CountryCodes != null)
              && (_isoCountryNames != null);
  }

  static String getDialCodeOf({String countryCode, String countryName}) {
    assert((countryCode != null) || (countryCode != null),
            "One of the parameters needs to have a valid value!");
    return (countryCode != null)? kISOCountryDialCodes[countryCode]
              : kISOCountryDialCodes[kISOCountryCodes[countryName]];
  }

  static String getAlpha2CodeOf({@required String countryName}) {
    return kISOCountryCodes[countryName];
  }
}
