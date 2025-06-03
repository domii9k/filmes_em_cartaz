import 'package:filmes_em_cartaz/data/apikey/api_key.dart';

String trendingWeekUrl = 'https://api.themoviedb.org/3/trending/all/week?api_key=$apikey';
String trendingDayUrl = 'https://api.themoviedb.org/3/trending/all/day?api_key=$apikey';
String popularMovieUrl = 'https://api.themoviedb.org/3/movie/popular?api_key=$apikey';
String nowPlayingMovieUrl = 'https://api.themoviedb.org/3/movie/now_playing?api_key=$apikey';
String topRatedMovieUrl = 'https://api.themoviedb.org/3/movie/top_rated?api_key=$apikey';
String upcomingMovieUrl = 'https://api.themoviedb.org/3/movie/latest?api_key=$apikey';