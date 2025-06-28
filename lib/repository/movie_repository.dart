import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:filmes_em_cartaz/data/apilinks/api_links.dart';
import 'package:filmes_em_cartaz/models/movie_model.dart';

class MovieRepository {
  final String apiKey; 
  
  MovieRepository({required this.apiKey});
  Future<List<MovieModel>> fetchTrending({bool week = true}) async {
    try {
      final url = week ? ApiLinks().trendingWeekUrl : ApiLinks().trendingDayUrl; //pega a url do dia ou semana
      final response = await http.get(Uri.parse(url)); //faz a requisição

      if (response.statusCode == 200) { //se a requisição foi bem sucedida
        final data = jsonDecode(response.body); //converte a resposta em json
        final results = data['results'] as List; //pega a lista de resultados
        
        return results 
            .where((item) => item['poster_path'] != null)
            .map((item) => MovieModel.fromJson(item))
            .toList(); //transforma a lista em objetos do tipo MovieModel
      } else {
        throw Exception('Falha ao carregar filmes: ${response.statusCode}'); //se a requisição falhar
      }
    } catch (e) {
      throw Exception('Erro ao carregar os dados: $e'); //se houver algum erro
    }
  }
}