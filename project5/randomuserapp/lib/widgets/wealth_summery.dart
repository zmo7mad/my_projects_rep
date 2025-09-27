import 'dart:math';



class WealthSummery {
  static int generateWealth() {

  final random = Random();   
    int min = 1000;
    int max = 100000;

    return min + random.nextInt(max - min + 1);
  }
}