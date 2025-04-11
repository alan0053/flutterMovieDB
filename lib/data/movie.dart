class Movie {
  int id;
  String title;
  String overview;
  DateTime? releaseDate;
  String? posterPath;
  double popularity;

  Movie(
    this.id,
    this.title,
    this.overview,
    this.releaseDate,
    this.posterPath,
    this.popularity,
  );

  // Named constructor with validation & defaults
  factory Movie.fromJson(Map<String, dynamic> data) {
    return Movie(
      data['id'] ?? 0,
      data['title'] ?? '',
      data['overview'] ?? '',
      data['release_date'] != null
          ? DateTime.tryParse(data['release_date'])
          : null,
      data['poster_path'],
      (data['popularity'] as num?)?.toDouble() ?? 0.0, // int or double
    );
  }
  // to JSON for rented movies
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'release_date': releaseDate?.year.toString(),
      'poster_path': posterPath,
      'popularity': popularity,
    };
  }
}
