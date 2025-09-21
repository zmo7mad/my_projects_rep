import 'package:flutter/material.dart';
import 'form.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form Validator',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const FormValidator(),
    );
}
}
