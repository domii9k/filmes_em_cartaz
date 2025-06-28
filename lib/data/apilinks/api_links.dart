import 'package:filmes_em_cartaz/data/apikey/api_key.dart';

class ApiLinks {
  String get trendingWeekUrl =>
      'https://api.themoviedb.org/3/trending/all/week?api_key=$api_key';

  String get trendingDayUrl =>
      'https://api.themoviedb.org/3/trending/all/day?api_key=$api_key';

  String get popularMovieUrl =>
      'https://api.themoviedb.org/3/movie/popular?api_key=$api_key';

  String get nowPlayingMovieUrl =>
      'https://api.themoviedb.org/3/movie/now_playing?api_key=$api_key';

  String get topRatedMovieUrl =>
      'https://api.themoviedb.org/3/movie/top_rated?api_key=$api_key';

  String get upcomingMovieUrl =>
      'https://api.themoviedb.org/3/movie/upcoming?api_key=$api_key';

  String get tmdbLink => 'https://www.themoviedb.org/';
}
