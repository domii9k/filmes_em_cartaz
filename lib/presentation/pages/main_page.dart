import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmes_em_cartaz/core/widgets/main_page_widgets/top_dez_filmes.dart';
import 'package:filmes_em_cartaz/data/apikey/api_key.dart';
import 'package:flutter/material.dart';
import 'package:filmes_em_cartaz/data/apilinks/api_links.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String? apikey = api_key; // API KEY
  List<Map<String, dynamic>> trendingWeek = [];
  bool isLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadTrendingWeek(1); // Carrega os dados da semana
  }

  Future<void> _loadTrendingWeek(int checkerno) async {
    setState(() {
      isLoading = true;
      trendingWeek = []; // Limpa a lista antes de carregar novos dados
    });

    try {
      final url = checkerno == 1 ? ApiLinks().trendingWeekUrl : ApiLinks().trendingDayUrl;
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = data['results'];
        
        // Filtra apenas itens que têm poster_path (imagem)
        final filteredResults = results.where((item) => 
          item['poster_path'] != null && 
          (item['title'] != null || item['name'] != null)
        ).toList();

        setState(() {
          trendingWeek = List<Map<String, dynamic>>.from(filteredResults.map((item) {
            return {
              'title': item['title'] ?? item['name'], // Para séries que usam 'name'
              'poster_path': item['poster_path'],
              'overview': item['overview'],
              'release_date': item['release_date'] ?? item['first_air_date'],
              'id': item['id'],
              'media_type': item['media_type'],
            };
          }));
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Erro ao carregar dados: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Erro na conexão: $e';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes em Destaque'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_view_week),
            onPressed: () => _loadTrendingWeek(1),
            tooltip: 'Trending da semana',
          ),
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _loadTrendingWeek(2),
            tooltip: 'Trending do dia',
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
  if (isLoading) {
    return const Center(child: CircularProgressIndicator());
  }

  if (errorMessage.isNotEmpty) {
    return Center(child: Text(errorMessage));
  }

  if (trendingWeek.isEmpty) {
    return const Center(child: Text('Nenhum resultado encontrado'));
  }

  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        CarouselSlider.builder(
          itemCount: trendingWeek.length,
          options: CarouselOptions(
            autoPlay: true,
            height: 600,
            aspectRatio: 16 / 9,
            enlargeCenterPage: false,
            viewportFraction: 1,
            autoPlayInterval: const Duration(seconds: 5),
          ),
          itemBuilder: (context, index, realIndex) {
            final item = trendingWeek[index];
            return GestureDetector(
              onTap: () {
                // Navegar para tela de detalhes
              },
              child: ClipRRect(
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(
                      imageUrl: 'https://image.tmdb.org/t/p/w500${item['poster_path']}',
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) => const Icon(Icons.error),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['title'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              item['release_date']?.toString().substring(0, 4) ?? 'N/A',
                              style: const TextStyle(color: Colors.white70),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        TopMoviesCarousel(movies: trendingWeek, title: "Top 10 Filmes"),
        const SizedBox(height: 20),
      ],
    ),
  );
}
}