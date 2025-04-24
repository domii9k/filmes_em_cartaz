import 'package:filmes_em_cartaz/core/widgets/root_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      home: RootPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}