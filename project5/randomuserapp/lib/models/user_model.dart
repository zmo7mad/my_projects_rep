import 'package:randomuserapp/widgets/wealth_summery.dart';
class UserModel {

  final String title;
  final String firstName;
  final String lastName;
  final int wealth;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.title,
    required this.wealth,
  });
  
  String get fullName => '$firstName $lastName';
  
  factory UserModel.fromApiAndWealth(Map<String , dynamic> apidata , int wealth){
  return UserModel(
    title: apidata['name']['title'],
    firstName:apidata['name'] ['first'],
    lastName:apidata['name'] ['last'],
    wealth: wealth
    
    
    
    );
  }
  
  






}
