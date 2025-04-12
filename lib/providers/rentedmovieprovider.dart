import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/movie.dart';

class RentedMovieProvider with ChangeNotifier {
  List<Movie> _rentedMovies = [];
  List<Movie> get rentedMovies => _rentedMovies;

  // using this because you cant call async directly
  RentedMovieProvider() {
    _loadRentedMovies();
  }

  Future<void> rentMovie(Movie movie) async {
    // prevent renting the same movie again
    if (!_rentedMovies.any((item) => item.id == movie.id)) {
      _rentedMovies.add(movie);
      notifyListeners();
      await _saveRentedMovies();
    }
  }

  Future<void> _saveRentedMovies() async {
    final prefs = await SharedPreferences.getInstance();
    // convert json string
    List<String> jsonMovie =
        _rentedMovies.map((movie) => jsonEncode(movie.toJson())).toList();
    await prefs.setStringList('rented_movies', jsonMovie);
  }

  Future<void> _loadRentedMovies() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonMovie = prefs.getStringList('rented_movies');
    if (jsonMovie != null) {
      _rentedMovies = jsonMovie
          .map((json) =>
              Movie.fromJson(jsonDecode(json) as Map<String, dynamic>))
          .toList();
      notifyListeners();
    }
  }

  Future<void> clearRentedMovies() async {
    _rentedMovies.clear();
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('rented_movies');
  }

  // not a best practice i believe for performance , but i didn't spent to much time to for find a better solution
  Future<void> removeMovieById(movieID) async {
    _rentedMovies.removeWhere((movie) => movie.id == movieID);
    notifyListeners();
    await _saveRentedMovies();
  }
}
