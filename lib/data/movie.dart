import 'dart:math';

class Movie {
  int id;
  String title;
  String overview;
  DateTime? releaseDate;
  String? posterPath;
  double popularity;
  int priceDollar;
  int priceCent;

  Movie(this.id, this.title, this.overview, this.releaseDate, this.posterPath,
      this.popularity, this.priceCent, this.priceDollar);

  // Named constructor with validation & defaults
  factory Movie.fromJson(Map<String, dynamic> data) {
    final random = Random();
    final dollar = random.nextInt(40) + 1;
    final cent = random.nextInt(100);

    return Movie(
      data['id'] ?? 0,
      data['title'] ?? '',
      data['overview'] ?? '',
      data['release_date'] != null
          ? DateTime.tryParse(data['release_date'])
          : null,
      data['poster_path'],
      (data['popularity'] as num?)?.toDouble() ?? 0.0, // int or double
      data['price_dollar'] ?? dollar,
      data['price_cent'] ?? cent,
    );
  }
  // to JSON for rented movies
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'overview': overview,
      'release_date': releaseDate?.toString(),
      'poster_path': posterPath,
      'popularity': popularity,
      'price_dollar': priceDollar,
      'price_cent': priceCent
    };
  }
}
