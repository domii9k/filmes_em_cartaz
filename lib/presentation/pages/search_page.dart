import 'dart:convert';
import 'dart:async';

import 'package:filmes_em_cartaz/data/apikey/api_key.dart';
import 'package:filmes_em_cartaz/presentation/pages/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  // Lista responsavel pela visualizacao dos itens pesquisados
  List<dynamic> _searchResults = [];
  // Lista original (sem filtros aplicados)
  List<dynamic> _allResults = [];
  // Loding da pagina
  bool _isLoading = false;
  // Filtro padrao como todos
  String _selectedFilter = 'Todos';
  Timer? _debounce;
  // Lista de filtros
  final List<String> _filters = [
    'Todos',
    'Melhor avaliados',
    'Lançamentos recentes',
    'Antigos',
    'Mais populares',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // Fazendo a pesquisa dos filmes
  Future<void> _searchMovies(String query) async {
    // caso o query esteja fazio a lista de resultado da pesquisa se mantera vazia
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _allResults = [];
      });
      return;
    }

    // Loding na tela
    setState(() {
      _isLoading = true;
    });

    // Buscando os dados da api com base na pesquisa
    try {
      // Url de consumo
      final url = "https://api.themoviedb.org/3/search/movie?api_key=$api_key&query=$query&language=pt-BR";
      // Transformando a url em um uri e fazendo um await para ser esperado este trecho ser executado por completo
      final response = await http.get(Uri.parse(url));

      // Se a resposta for ok pela api faca
      if (response.statusCode == 200) {
        // Decoficada a resposta de um json para um final data
        final data = json.decode(response.body);
        // Muda o estado para que a Lista de resultado da pesquisa contenha o valor de data
        setState(() {
          _allResults = data['results'];
          // Aplica o filtro selecionado a lista de filmes
          _applyFilter();
        });
      } else {
        throw Exception('Falha ao carregar filmes');
      }
    } catch (e) {
      // Mensagem de erro no rodape da tela
      showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Erro'),
            content: Text('$e'),
          );
        },
      );
    } finally {
      // por fim faz com que o loading pare
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Aplicar o filtro na lista de filmes
  void _applyFilter() {
    switch (_selectedFilter) {
      case 'Melhor avaliados':
        _searchResults = List.from(_allResults)..sort(
          (a, b) =>
              (b['vote_average'] ?? 0.0).compareTo(a['vote_average'] ?? 0.0),
        );
        break;
      case 'Lançamentos recentes':
        _searchResults = List.from(_allResults)..sort((a, b) {
          final dateA =
              DateTime.tryParse(a['release_date'] ?? '') ?? DateTime(1900);
          final dateB =
              DateTime.tryParse(b['release_date'] ?? '') ?? DateTime(1900);
          return dateB.compareTo(dateA);
        });
        break;
      case 'Antigos':
        _searchResults = List.from(_allResults)..sort((a, b) {
          final dateA =
              DateTime.tryParse(a['release_date'] ?? '') ?? DateTime.now();
          final dateB =
              DateTime.tryParse(b['release_date'] ?? '') ?? DateTime.now();
          return dateA.compareTo(dateB);
        });
        break;
      case 'Mais populares':
        _searchResults = List.from(_allResults)..sort((a, b) {
          final popularityA = (a['popularity'] ?? 0.0);
          final popularityB = (b['popularity'] ?? 0.0);
          return popularityB.compareTo(popularityA);
        });
        break;

      default:
        _searchResults = List.from(_allResults);
    }
  }

  // PopUp de filtros
  void _showFilterDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.grey[900],
          title: const Text(
            'Filtrar por',
            style: TextStyle(color: Colors.white),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: _filters.length,
              itemBuilder: (context, index) {
                return RadioListTile<String>(
                  title: Text(
                    _filters[index],
                    style: TextStyle(
                      color:
                          _selectedFilter == _filters[index]
                              ? Colors.redAccent
                              : Colors.white,
                    ),
                  ),
                  value: _filters[index],
                  groupValue: _selectedFilter,
                  activeColor: Colors.redAccent,
                  onChanged: (value) {
                    setState(() {
                      _selectedFilter = value!;
                      _applyFilter();
                    });
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // capturando o tamanho da tela
    final responsive = screenSize.width; // adicionando o tamanho da tela em uma variavel
    // Toda a tela
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // Parte superior da tela que contem a barra de pesquisa
          SliverAppBar(
            pinned: true,
            floating: true,
            backgroundColor: Colors.black,
            title: Container(
              margin: responsive >= 600 ? EdgeInsets.symmetric(horizontal: 50) : EdgeInsets.symmetric(horizontal: 0),
              height: 45,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 30, 30, 30),
                borderRadius: BorderRadius.circular(25),
              ),

              // Input referente a barra de pesquisa
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Pesquise por algum filme...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  prefixIcon: IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.pop(context),
                  ),
                  suffixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.filter_alt, color: Colors.white),
                        onPressed: _showFilterDialog,
                      ),
                      IconButton(
                        icon: const Icon(Icons.search, color: Colors.white),
                        onPressed: () => _searchMovies(_searchController.text),
                      ),
                    ],
                  ),
                ),
                style: const TextStyle(color: Colors.white),
                onChanged: (query) {
                  if (_debounce?.isActive ?? false) _debounce?.cancel();
                  _debounce = Timer(const Duration(milliseconds: 500), () {
                    _searchMovies(query);
                  });
                },
                onSubmitted: _searchMovies,
              ),
            ),
          ),

          // Mostrando filtro selecionado
          if (_searchResults.isNotEmpty)
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    const Text(
                      'Filtro: ',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Chip(
                      label: Text(
                        _selectedFilter,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.redAccent,
                    ),
                  ],
                ),
              ),
            ),

          // Carregando
          if (_isLoading)
            const SliverFillRemaining(
              child: Center(
                child: CircularProgressIndicator(color: Colors.redAccent),
              ),
            )
          // Se nao estiver carregando
          else if (_searchResults.isEmpty)
            // Conteudo da tela com os filmes pesquisados
            SliverFillRemaining(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon no centro da tela
                    const Icon(Icons.search, size: 80, color: Colors.grey),
                    const SizedBox(height: 16),
                    // Se nenhum filme pesquisado mostra um texto
                    // se nao estiver nenhum filme com o nome pesquisa mostra outro texto
                    Text(
                      _searchController.text.isEmpty
                          ? 'Que tal procurar algum filme 🍿😋'
                          : 'Nenhum resultado encontrado 😥',
                      style: const TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ],
                ),
              ),
            )
          // Se nao for nenhum dos casos anteriores mostrar a lista de filmes
          else
            SliverPadding(
              padding: const EdgeInsets.all(16),
              // Grade dos filmes
              sliver: SliverGrid(
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  // Quantos filmes por linha
                  crossAxisCount: responsive >= 600 ? 7 : 3,
                  // Espacamento horizontal entre os filmes
                  crossAxisSpacing: 16,
                  // Espacamento vertical entre os filmes
                  mainAxisSpacing: 16,
                  // Tamanho
                  childAspectRatio: 0.6,
                ),
                // imagem do filme
                delegate: SliverChildBuilderDelegate((context, index) {
                  final movie = _searchResults[index];
                  final posterUrl =
                      movie['poster_path'] != null
                          ? 'https://image.tmdb.org/t/p/w500${movie['poster_path']}'
                          : null;

                  // Navegar para os detalhes do filme
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieDetailsPage(movie: movie),
                        ),
                      );
                    },
                    // Toda a area de cada filme mostrado
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // se filme conter uma imagem mostra a mesma
                          if (posterUrl != null)
                            CachedNetworkImage(
                              imageUrl: posterUrl,
                              fit: BoxFit.cover,
                              placeholder:
                                  (context, url) =>
                                      Container(color: Colors.grey[900]),
                              errorWidget:
                                  (context, url, error) => Container(
                                    color: Colors.grey[900],
                                    child: const Icon(
                                      Icons.error,
                                      color: Colors.white,
                                    ),
                                  ),
                            )
                          // se nao mostra o titulo no lugar
                          else
                            Container(
                              color: Colors.grey[900],
                              child: Center(
                                child: Text(
                                  movie['title'] ?? 'Sem título',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),

                          // gradiente de baixo para cima junto as informacoes do filme
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    Colors.black.withOpacity(0.9),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Titulo do filme
                                  Text(
                                    movie['title'] ?? 'Sem título',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      // Estrela de avaliacao
                                      const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                        size: 16,
                                      ),
                                      const SizedBox(width: 4),
                                      // Avaliacao
                                      Text(
                                        '${movie['vote_average']?.toStringAsFixed(1) ?? 'N/A'}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const Spacer(),
                                      // Data de lancamento se nao tiver mostra N/A
                                      Text(
                                        movie['release_date'] != null &&
                                                movie['release_date'].length >=
                                                    4
                                            ? movie['release_date'].substring(
                                              0,
                                              4,
                                            )
                                            : 'N/A',
                                        style: const TextStyle(
                                          color: Colors.white70,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }, childCount: _searchResults.length),
              ),
            ),
        ],
      ),
    );
  }
}
