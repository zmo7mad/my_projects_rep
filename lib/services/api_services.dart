import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:exchangeratecal/models/exchangerate.dart';

class ApiServices {
// the api key for the exchange rate website is hardcodded .. and it shouldnt be .. its for learning purposes only
static const String token = "e378d361c05e1a3b806aca52";
static const String _baseUrl = "https://v6.exchangerate-api.com/v6";

double? exchangerate;

   Future<ExchangeRate> fetchRates(String baseCode) async {
    final url = '$_baseUrl/$token/latest/$baseCode';
    print('fetching rates from : $url');

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      print('the api response is : $jsonData');

      if (jsonData['result'] == 'success') {
       return ExchangeRate.fromjson(jsonData);
      }
    else{
      throw Exception('api returned error: ${jsonData['error-type']}');
    }
      
    }
    else {
      throw Exception('Failed to load exchange rates');
    }
  }
  Future<List<String>> fetchCurrencies() async
  {
    final url = "$_baseUrl/$token/codes";
    print('fetching currenices from : $url');
     final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200)
    {
      final data = json.decode(response.body);
      final List codes = data['supported_codes'];
      return codes.map<String>((c) => c[0]).toList();
    }
    else 
    {
      throw Exception('failed to fetch currencies');
    }
  }



}