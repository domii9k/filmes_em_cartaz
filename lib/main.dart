import 'package:filmes_em_cartaz/core/widgets/root_page.dart';
import 'package:filmes_em_cartaz/presentation/pages/search_page.dart';
import 'package:filmes_em_cartaz/provider/movie_provider.dart';
import 'package:filmes_em_cartaz/repository/movie_repository.dart';
import 'package:filmes_em_cartaz/data/apikey/api_key.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MovieProvider(MovieRepository(apiKey: api_key)),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Movie App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF121011),
          brightness: Brightness.dark,
        ),
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => const RootPage(),
        '/search': (context) => const SearchPage(),
      },
    );
  }
}
