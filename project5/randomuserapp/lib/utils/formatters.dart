import 'dart:math';
import 'package:randomuserapp/models/user_model.dart';
import 'package:randomuserapp/widgets/wealth_summery.dart';

class Formatters {
  
  static String formatCurrency(int amount) 
  {
    String money = amount.toString();
    String backwards = '';
    
    for (int i = money.length - 1; i >= 0; i--)
     {
      backwards += money[i];
    }
    
    String withCommas = '';
    
    for (int i = 0; i < backwards.length; i++)
     {
      withCommas += backwards[i];
      
      if ((i + 1) % 3 == 0 && i < backwards.length - 1) 
      {
        withCommas += ',';
      }
    }
    
    String normal = '';
    for (int i = withCommas.length - 1; i >= 0; i--) {
      normal += withCommas[i];
    }
    
    return '\$' + normal;
  }
  
  static String formatLargeNumber(int amount) {
    if (amount >= 1000000) {
      double millions = amount / 1000000;
      return '\$${millions.toStringAsFixed(1)}M';
    } else {
      return formatCurrency(amount);
    }
  }
}