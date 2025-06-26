import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:material_symbols_icons/symbols.dart';

class MovieDetailsPage extends StatefulWidget {
  final Map<String, dynamic> movie;
  
  const MovieDetailsPage({super.key, required this.movie});

  @override
  State<MovieDetailsPage> createState() => _MovieDetailsPageState();
}

class _MovieDetailsPageState extends State<MovieDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final movie = widget.movie;
    final posterUrl = 'https://image.tmdb.org/t/p/w500${movie['poster_path']}';
    final backdropUrl = 'https://image.tmdb.org/t/p/original${movie['backdrop_path']}';

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar com imagem de fundo
          SliverAppBar(
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
                    errorWidget: (context, url, error) => Icon(Icons.error),
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
          ),

          // Corpo da página
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Cabeçalho com poster e informações básicas
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Poster do filme
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
                      // Informações básicas
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              movie['title'] ?? movie['name'] ?? 'Sem título',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.star, color: Colors.amber, size: 20),
                                const SizedBox(width: 4),
                                Text(
                                  '${movie['vote_average']?.toStringAsFixed(1) ?? 'N/A'}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                                const SizedBox(width: 16),
                                Text(
                                  _formatDuration(movie['runtime']),
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _formatGenres(movie['genres']),
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _formatReleaseDate(movie['release_date'] ?? movie['first_air_date']),
                              style: TextStyle(color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Botão de assistir
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Ação para assistir o filme
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
                  ),
                  const SizedBox(height: 24),

                  // Sinopse
                  const Text(
                    'Sinopse',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    movie['overview'] ?? 'Sinopse não disponível',
                    style: const TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 24),

                  // Informações técnicas
                  const Text(
                    'Informações',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildInfoRow('Data de lançamento', _formatReleaseDate(movie['release_date'] ?? movie['first_air_date'])),
                  _buildInfoRow('Duração', _formatDuration(movie['runtime'])),
                  _buildInfoRow('Classificação', _getAgeRating(movie['adult'])),
                  _buildInfoRow('Idiomas', _formatLanguages(movie['spoken_languages'])),
                  const SizedBox(height: 24),

                  // Trailers (se disponível)
                  if (movie['videos']?['results'] != null && movie['videos']['results'].isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Trailers',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 200,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: movie['videos']['results'].length,
                            itemBuilder: (context, index) {
                              final video = movie['videos']['results'][index];
                              return Container(
                                width: 300,
                                margin: const EdgeInsets.only(right: 16),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      'https://img.youtube.com/vi/${video['key']}/hqdefault.jpg',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: Center(
                                  child: IconButton(
                                    icon: const Icon(Icons.play_circle_filled, size: 50, color: Colors.white),
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
                    ),
                ],
              ),
            ),
          ),
        ],
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

  String _formatDuration(int? minutes) {
    if (minutes == null) return 'N/A';
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return '${hours}h ${remainingMinutes}m';
  }

  String _formatGenres(List<dynamic>? genres) {
    if (genres == null || genres.isEmpty) return 'N/A';
    return genres.map<String>((g) => g['name']).join(', ');
  }

  String _formatReleaseDate(String? date) {
    if (date == null) return 'N/A';
    final parsedDate = DateTime.tryParse(date);
    if (parsedDate == null) return 'N/A';
    return '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
  }

  String _formatLanguages(List<dynamic>? languages) {
    if (languages == null || languages.isEmpty) return 'N/A';
    return languages.map<String>((l) => l['english_name']).join(', ');
  }

  String _getAgeRating(bool? adult) {
    return adult == true ? '18+' : 'Livre';
  }
}