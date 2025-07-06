import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:filmes_em_cartaz/core/widgets/main_page_widgets/top_filmes.dart';
import 'package:filmes_em_cartaz/presentation/pages/movie_details_page.dart';
import 'package:filmes_em_cartaz/provider/movie_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    // carrega a pagina quando iniciada
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<MovieProvider>(
        context,
        listen: false,
      ).fetchTrendingMovies(); // carrega as informações de filmes
    });
  }

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(
      context,
    ); // acessa o provider de filmes
    final screenSize =
        MediaQuery.of(context).size; // capturando o tamanho da tela
    final responsive =
        screenSize.width; // adicionando o tamanho da tela em uma variavel

    return Scaffold(
      body:
          movieProvider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : movieProvider.errorMessage.isNotEmpty
              ? Center(child: Text(movieProvider.errorMessage))
              : SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    CarouselSlider.builder(
                      // carrosel de filmes
                      itemCount: movieProvider.trendingMovies.length,
                      options: CarouselOptions(
                        autoPlay: true, // carrossel automatico
                        height: responsive >= 600 ? 400 : 600,
                        aspectRatio: 16 / 9,
                        enlargeCenterPage: false,
                        viewportFraction: 1,
                        autoPlayInterval: const Duration(seconds: 5),
                      ),
                      itemBuilder: (context, index, realIndex) {
                        final movie = movieProvider.trendingMovies[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => MovieDetailsPage(movie: movie),
                              ),
                            );
                          },
                          child: ClipRRect(
                            child: Stack(
                              fit: StackFit.expand,
                              children: [
                                CachedNetworkImage(
                                  imageUrl:
                                      'https://image.tmdb.org/t/p/original${movie.posterPath}',
                                  fit: BoxFit.cover,
                                  placeholder:
                                      (context, url) => const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                                  errorWidget:
                                      (context, url, error) =>
                                          const Icon(Icons.error),
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
                                        colors: [
                                          Colors.black.withOpacity(0.8),
                                          Colors.transparent,
                                        ],
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Titulo do Filme
                                        Text(
                                          movie.fullTitle,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize:
                                                responsive >= 600 ? 50 : 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        // Ano do Filme
                                        Text(
                                          movie.year,
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize:
                                                responsive >= 600 ? 30 : 14,
                                          ),
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
                    TopMoviesCarousel(
                      movies: movieProvider.trendingMovies,
                      title: "Top Filmes da Semana",
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
    );
  }
}
