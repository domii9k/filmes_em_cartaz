import 'dart:convert';

import 'package:filmes_em_cartaz/domain/entities/movie_entity.dart';
import 'package:filmes_em_cartaz/domain/exceptions/not_found_exception.dart';
import 'package:filmes_em_cartaz/data/http/http_client.dart';


abstract class AbstractMovie {
  Future<List<MovieEntity>> getMovies();
}

class MovieRepository implements AbstractMovie {
  final GetHttpClient api;

  MovieRepository({required this.api});

  @override
  Future<List<MovieEntity>> getMovies() async{
    final response = await api.get(
      url: "https://api.themoviedb.org/3/movie/popular?language=pt-BR",
      token:  "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwNzlhNjhmNWRmNzllOTRmMDc4OTVhNDgxYWJkNjk0MCIsIm5iZiI6MTc0NTA2NDc2Mi4wOTEsInN1YiI6IjY4MDM5MzNhMzkxYjkyNzAxOWQ5MmViZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.quQagLWV-qKC2gnxE2z6rNLRE-d_VOF0h7INIU_6wE8"
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final List<MovieEntity> movies = [];

      body['results'].map((item){
        final MovieEntity movie = MovieEntity.fromMap(item);
        movies.add(movie);
      });

       return movies;
    } else if (response.statusCode == 400) {
      throw CustomNotFoundException('A url informada não é válida!');
    } else {
      throw Exception('Não foi possível carregar os produtos!');
    }
      

  }
  }