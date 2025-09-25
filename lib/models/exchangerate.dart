import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:exchangeratecal/services/api_services.dart';
class ExchangeRate {
  final String base ;
  final Map<String , dynamic> rates;
   
   ExchangeRate({
    required this.base,
    required this.rates,
   });
   factory ExchangeRate.fromjson(Map<String , dynamic> json)
   {
     return ExchangeRate(

      base: json['base_code'] ?? '',
      rates : Map<String , dynamic>.from(json['conversion_rates'] ?? {}),
     );

   }
   
}
class ExchangeRateScreen extends StatefulWidget
{
const ExchangeRateScreen({super.key});
@override

State<ExchangeRateScreen> createState() => _ExchangeRateScreenState();
}
class _ExchangeRateScreenState extends State<ExchangeRateScreen>
{
    List<String> currencies= [];
    String? selectedBase;
    String? selectedTarget;
    double? exchangerate;
    bool isLoading =false;

    @override
    void initState()
{
  super.initState();
  _loadCurrencies();
}
Future<void> _fetchedExchangeRates() async {
  if (selectedBase == null || selectedTarget == null || selectedTarget!.isEmpty) {
    print('Selected base or target is null/empty');
    return;
  }

  try {
    final api = ApiServices();
    final ratesData = await api.fetchRates(selectedBase!);

    setState(() {
      exchangerate = ratesData.rates.containsKey(selectedTarget)
          ? (ratesData.rates[selectedTarget] as num).toDouble()
          : null;
    });

    print("Available rates: ${ratesData.rates.keys}");
  } catch (e) {
    print("Error fetching exchange rate: $e");
  }

}
Future<void> _loadCurrencies() async
{
 try
    {
    final api = ApiServices();
    final fethcedCurrencies = await api.fetchCurrencies();
    
    setState(() {
      
      currencies = fethcedCurrencies;
      if (fethcedCurrencies.isNotEmpty) {
      selectedBase = fethcedCurrencies.first;
      selectedTarget = currencies[1];
      }
      isLoading =false;
    });   
  }
  catch(e)
  {
    throw Exception('failed to load the curreinces : $e');
  }
}
@override
Widget build(BuildContext context)
{ return Scaffold(
    appBar: AppBar(
      title: const Text('the exchange rate app'),
      backgroundColor: Colors.amber
    ),
    body: Padding (
      padding: EdgeInsets.all(130) ,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Text(
            'the base currency '
          ),
          // this drop list is for the base currency
         DropdownButton(
          value: selectedBase ,
          items: currencies.map((currency) {
            return DropdownMenuItem(
              value:currency,
              child: Text(currency),
            );
          }).toList(),
          onChanged: (value) async
          {
            setState(() {
              selectedBase = value;
            });
           await  _fetchedExchangeRates();

          },
         ),
         const SizedBox(height: 20),

         Text( 'the target currency '),
          // this drop list is for the target currency
         DropdownButton(
          value: selectedTarget,
          items: currencies.map((currency) {
            return DropdownMenuItem(
              value:currency,
              child: Text(currency),
            );
          }).toList(),
          onChanged: (value) async
          {
            setState(() {
              selectedTarget = value;
            });
            await  _fetchedExchangeRates();

          },
         
         ),
         const SizedBox(height: 22,),
        ElevatedButton(
          onPressed: 
          _fetchedExchangeRates, 
          child: Text('get the rate' ) ,
        
          ),
          const SizedBox(height: 22),
            exchangerate != null
            ? Text('1 $selectedBase = $exchangerate $selectedTarget',
            style: 
            TextStyle(
              fontSize:22 , 
              
            ),
            ) 
            : Text('no data'),
           
        
        ],
      ) 
    )
  );
}


}
