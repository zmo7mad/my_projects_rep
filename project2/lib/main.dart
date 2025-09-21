import 'package:flutter/material.dart';
import 'package:movieseatbookingapp/seatbooking.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
void main() {
  
  runApp(
    const ProviderScope(
    child: MyApp(),
    ),
     );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title : 'movie set booking',
      theme : ThemeData.dark(),
      home: Seatbooking(),
    );
  }
}