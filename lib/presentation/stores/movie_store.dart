import 'package:filmes_em_cartaz/data/repositories/movie_repository.dart';
import 'package:filmes_em_cartaz/domain/entities/movie_entity.dart';
import 'package:filmes_em_cartaz/domain/exceptions/not_found_exception.dart';
import 'package:flutter/cupertino.dart';

class MovieStore {
  final AbstractMovie repository;

  final ValueNotifier<bool> _isFetching = ValueNotifier<bool>(false);

  final ValueNotifier<List<MovieEntity>> state =
      ValueNotifier<List<MovieEntity>>([]);

  final ValueNotifier<String> error = ValueNotifier<String>('');

  MovieStore({required this.repository});

  Future getMovies() async {
    _isFetching.value = true;

    try {
      final response = await repository.getMovies();
      state.value = response;
    } on CustomNotFoundException catch (e) {
      error.value = e.message;
    } catch (e) {
      error.value = e.toString();
    }

    _isFetching.value = false;
  }
}
