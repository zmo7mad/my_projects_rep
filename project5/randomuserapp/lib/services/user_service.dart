import 'dart:convert';
import 'package:randomuserapp/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:randomuserapp/widgets/wealth_summery.dart';
class UserService {
  
  static const String _baseurl = 'https://randomuser.me/api/';

  Future<UserModel?> fetchRandomUser() async
  { try {
    final url = '$_baseurl';
    print('fetching the data from : $url');
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200)
    {
      final jsonData = jsonDecode(response.body);
      print('the api repsone is : $jsonData');
      final userData = jsonData['results'] [0];
      final generateWealth = WealthSummery.generateWealth();
      return UserModel.fromApiAndWealth(userData, generateWealth);

    }
   return null;  
  }
      catch(e)
      {
         print('an error has ocurred : $e ');
         return null ; 
      }

  }



}