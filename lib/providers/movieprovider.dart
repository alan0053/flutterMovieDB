import 'package:flutter/material.dart';
import '../data/movie.dart';
import '../data/httphelper.dart';

class MovieProvider with ChangeNotifier {
  final HttpHelper _httpHelper = HttpHelper();

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;

  int get length => _movies.length;

  Future<List<Movie>> search(String keyword) async {
    try {
      _movies = await _httpHelper.searchMovies(keyword);
    } catch (e) {
      _movies = [];
    }
    notifyListeners();
    return _movies;
  }

  void clearResults() {
    _movies.clear();
    notifyListeners();
  }
}
