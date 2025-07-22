import 'package:flutter/material.dart';
import 'views/dictionary_page.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Financial Dictionary',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xff1d324f)),
        useMaterial3: true,
      ),
      
      home: const DictionaryPage(),
    );
  }
}