import 'package:filmes_em_cartaz/models/movie_model.dart';
import 'package:filmes_em_cartaz/repository/movie_repository.dart';
import 'package:flutter/material.dart';

class MovieProvider with ChangeNotifier {
  final MovieRepository _repository;
  List<MovieModel> _trendingMovies = [];
  bool _isLoading = false; 
  String _errorMessage = '';

  MovieProvider(this._repository);

  List<MovieModel> get trendingMovies => _trendingMovies; // lista de filmes populares
  bool get isLoading => _isLoading; // indica se está carregando
  String get errorMessage => _errorMessage;

  Future<void> fetchTrendingMovies({bool week = true}) async { // função para buscar filmes populares
    _isLoading = true;
    notifyListeners(); // atualiza a tela

    try {
      _trendingMovies = await _repository.fetchTrending(week: week); // busca filmes populares
      _errorMessage = ''; // limpa mensagem de erro
    } catch (e) { 
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners(); // atualiza a tela
    }
  }
}