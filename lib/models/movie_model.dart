class MovieModel {
  final int id;
  final String? title;
  final String? name;
  final String mediaType;
  final String posterPath;
  final String? releaseDate;
  final String? firstAirDate;
  final String overview;
  final String? backdropPath;
  final int? runtime;
  final bool? adult;
  final double voteAvarage;


  
  MovieModel({
    required this.id,
    this.title,
    this.name,
    required this.mediaType,
    required this.posterPath,
    this.releaseDate,
    this.firstAirDate,
    required this.overview,
    this.backdropPath,
    this.runtime,
    this.adult,
    required this.voteAvarage  
  });

  String get fullTitle => title ?? name ?? 'Sem título';
  String get year => (releaseDate ?? firstAirDate ?? '').length >= 4 
      ? (releaseDate ?? firstAirDate)!.substring(0, 4) 
      : 'N/A';

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'],
      name: json['name'],
      mediaType: json['media_type'],
      posterPath: json['poster_path'],
      releaseDate: json['release_date'],
      firstAirDate: json['first_air_date'],
      overview: json['overview'],
      backdropPath: json['backdrop_path'],
      runtime: json['runtime'],
      adult: json['adult'],
      voteAvarage: json['vote_average'],
    );
  }
}
