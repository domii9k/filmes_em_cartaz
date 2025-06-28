import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:filmes_em_cartaz/models/movie_model.dart';

class MovieDetailsPage extends StatelessWidget {
  final MovieModel movie;
  
  const MovieDetailsPage({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final posterUrl = 'https://image.tmdb.org/t/p/w500${movie.posterPath}'; //url do poster do filme
    final backdropUrl = 'https://image.tmdb.org/t/p/original${movie.backdropPath}'; //url da imagem de fundo do filme

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildAppBar(backdropUrl, context), //AppBar com imagem de fundo 
          _buildMovieDetails(posterUrl, theme), //Detalhes do filme
        ],
      ),
    );
  }

  SliverAppBar _buildAppBar(String backdropUrl, BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.0,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: backdropUrl,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(color: Colors.grey[800]),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [Colors.black.withOpacity(0.7), Colors.transparent],
                ),
              ),
            ),
          ],
        ),
      ),
      leading: IconButton(
        icon: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.5),
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(Symbols.more_vert_rounded, color: Colors.white),
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  SliverToBoxAdapter _buildMovieDetails(String posterUrl, ThemeData theme) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildMovieHeader(posterUrl, theme),
            const SizedBox(height: 24),
            _buildWatchButton(),
            const SizedBox(height: 24),
            _buildSectionTitle('Sinopse', theme),
            const SizedBox(height: 8),
            Text(
              movie.overview,
              style: const TextStyle(fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle('Informações', theme),
            const SizedBox(height: 8),
            _buildInfoRow('Data de lançamento', _formatReleaseDate(movie.releaseDate ?? movie.firstAirDate)),
            _buildInfoRow('Classificação', _getAgeRating(movie.adult)),
            /* if (movie.videos?.results.isNotEmpty ?? false) ...[ //se tiver videos/trailer
              const SizedBox(height: 24),
              _buildTrailersSection(theme), // seção de trailer do filme
            ], */
            SizedBox(height: 100,)
          ],
        ),
      ),
    );
  }

  Widget _buildMovieHeader(String posterUrl, ThemeData theme) { // cabeçalho do filme
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            imageUrl: posterUrl,
            height: 180,
            width: 120,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[800],
              height: 180,
              width: 120,
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                movie.fullTitle,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 20),
                  const SizedBox(width: 4),
                  Text(
                    movie.voteAvarage ?? 'N/A',
                    style: theme.textTheme.bodyLarge,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                _formatReleaseDate(movie.releaseDate ?? movie.firstAirDate),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildWatchButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // botao para assistir o filme
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.redAccent,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.play_arrow, size: 24),
            SizedBox(width: 8),
            Text(
              'Assistir agora',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, ThemeData theme) {
    return Text(
      title,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  /* Widget _buildTrailersSection(ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Trailers', theme),
        const SizedBox(height: 8),
        SizedBox(
          height: 200,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movie.videos!.results.length,
            itemBuilder: (context, index) {
              final video = movie.videos!.results[index];
              return Container(
                width: 300,
                margin: const EdgeInsets.only(right: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://img.youtube.com/vi/${video.key}/hqdefault.jpg',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Center(
                  child: IconButton(
                    icon: const Icon(Icons.play_circle_filled, 
                      size: 50, 
                      color: Colors.white),
                    onPressed: () {
                      // Abrir trailer
                    },
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  } */

  String _formatReleaseDate(String? date) {
    if (date == null) return 'N/A';
    final parsedDate = DateTime.tryParse(date);
    if (parsedDate == null) return 'N/A';
    return '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
  }

  String _getAgeRating(bool? adult) {
    return adult == true ? '18+' : 'Livre';
  }
}