class MovieEntity {
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final String releaseDate;

  MovieEntity({
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.releaseDate,
  });

  factory MovieEntity.fromMap(Map<String, dynamic> map) {
    return MovieEntity(
      title: map['title'],
      overview: map['overview'],
      posterPath: map['poster_path'],
      backdropPath: map['backdrop_path'],
      releaseDate: map['release_date'],
    );
  }
}
