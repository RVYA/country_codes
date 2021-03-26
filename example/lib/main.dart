import 'package:flutter/material.dart';

import 'package:country_codes/country_codes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await CountryCodes.initialize();

  runApp(ExampleApp());
}


class ExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String deviceCountryCode = CountryCodes.deviceLocale.countryCode;
    
    for (String countryCode in CountryCodes.isoAlpha2CountryCodes) {
      print("$countryCode ");
    }

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text("Country Code: $deviceCountryCode"),
              Text("Dial Code: ${CountryCodes.getDialCodeOf(countryCode: deviceCountryCode)}"),
              Text("Dial Code of AF: ${CountryCodes.getDialCodeOf(countryCode: "AF")}"),
            ],
          ),
        ),
      ),
    );
  }
}
