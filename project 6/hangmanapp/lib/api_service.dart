import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class ApiService {
  static const String baseUrl = 'https://api.api-ninjas.com/v1/randomword';


  Future<String> fetchRandomWords() async{
    final url = '$baseUrl';
    final String Token = 'FC49fKitIKuKgA3kuEJTcg==UVNLDIvgQSGUvqom';
    final response =await http.get(Uri.parse(url),
    headers: {
       'X-Api-Key' : Token,
    });
      print('Response status: ${response.statusCode}');  
        print('Response body: ${response.body}'); 


    if (response.statusCode == 200)
    {
      final jsonData = jsonDecode(response.body);
      List<dynamic> wordList = jsonData['word'];
      return wordList [0];
    }else {
      throw Exception('failed to fetch from api');
    }


  }
}