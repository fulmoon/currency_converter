import 'dart:convert';

import 'package:http/http.dart' as http;

class CurrencyApi {
  Future<Map<String, dynamic>> getCurrencies() async {
    Uri url = Uri.parse('https://v6.exchangerate-api.com/v6/7dc181213053b76e1f613fc5/latest/USD');

    http.Response response = await http.get(url);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');

    String jsonString = response.body;

    Map<String, dynamic> json = jsonDecode(jsonString);
    if(json['conversion_rates'] == null){
      return {};
    }
    // print(json['conversion_rates']);

    //Map<String, dynamic>  conversionRates = await jsonDecode(json['conversion_rates']);
    // print(conversionRates);
    // Map<dynamic, dynamic> currency = jsonDecode(conversionRates);
    // print(currency);

    Map<String, dynamic> currencies = json['conversion_rates'];
    return currencies;
    //return currencies.map((e) => CurrencyList.fromJson(e)).toList();
  }
}