import 'dart:convert';
import 'package:http/http.dart' as http;
import 'movie.dart';

class HttpHelper {
  final String domain = 'api.themoviedb.org';
  final String apiKey = 'Key';
  final String path = '/3/search/movie';

  Future<List<Movie>> searchMovies(String keyword) async {
    Map<String, String> params = {
      'api_key': apiKey,
      'query': keyword,
      'language': 'en-US',
    };

    Uri uri = Uri.https(domain, path, params);
    http.Response result = await http.get(uri);

    if (result.statusCode == 200) {
      // checking for success
      // Decode the JSON response
      Map<String, dynamic> json = jsonDecode(result.body);
      // Extract the results
      List<dynamic> results = json['results'];
      // Map the results to Movie objects
      // and return the list of movies
      List<Movie> movies = results.map((data) => Movie.fromJson(data)).toList();
      return movies;
    } else {
      throw Exception('Failed to fetch movies: ${result.statusCode}');
    }
  }
}
