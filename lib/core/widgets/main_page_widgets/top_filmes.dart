import 'package:filmes_em_cartaz/models/movie_model.dart';
import 'package:filmes_em_cartaz/presentation/pages/movie_details_page.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TopMoviesCarousel extends StatefulWidget {
  final List<MovieModel> movies;
  final String title;
  
  const TopMoviesCarousel({
    super.key,
    required this.movies,
    required this.title,
  });

  @override
  State<TopMoviesCarousel> createState() => _TopMoviesCarouselState();
}

class _TopMoviesCarouselState extends State<TopMoviesCarousel> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size; // capturando o tamanho da tela
    final responsive = screenSize.width; // adicionando o tamanho da tela em uma variavel

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            widget.title,
            style: TextStyle(
              fontSize: responsive >= 600 ? 35 : 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Column(
          children: [
            CarouselSlider.builder(
              itemCount: widget.movies.length,
              itemBuilder: (context, index, realIndex) {
                final movie = widget.movies[index];
                return _buildMovieCard(movie, index);
              },
              options: CarouselOptions(
                height: 280, // tamanho do carrossel
                viewportFraction: responsive >= 600 ? 0.10 : 0.35, // gap entre os filmes
                enlargeCenterPage: false,
                autoPlay: true, // movimentacao automatica
                autoPlayInterval: const Duration(seconds: 3), // tempo de deslizamento automatico
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Card do carrossel
  Widget _buildMovieCard(MovieModel movie, int index) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsPage(movie: movie),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),

                  // Imagem do filme
                  child: CachedNetworkImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                    height: 200,
                    width: 120,
                    fit: BoxFit.cover,
                    // Carregando a imagem
                    placeholder: (context, url) => Container(
                      color: Colors.grey[800],
                      height: 500,
                      width: 120,
                      child: const Center(child: CircularProgressIndicator()),
                    ),
                    // Erro ao nao carregar a imagem
                    errorWidget: (context, url, error) => Container(
                      color: Colors.grey[800],
                      height: 200,
                      width: 120,
                      child: const Icon(Icons.error, color: Colors.white),
                    ),
                  ),
                ),

                // Button player
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent[700],
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          blurRadius: 6,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.play_arrow, color: Colors.white),
                      iconSize: 20,
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MovieDetailsPage(movie: movie),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Titulo do filme
            SizedBox(
              width: 120,
              child: Text(
                movie.fullTitle,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
              ),
            ),

            // Avaliacao do filme
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.yellow, size: 16),
                const SizedBox(width: 4),
                Text(
                  movie.voteAvarage > 0 ? movie.voteAvarage.toString() : 'N/A',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}