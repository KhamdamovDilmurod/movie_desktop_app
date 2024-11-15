
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/movie_model.dart';

class MovieDatabaseService {
  static const String _movieListKey = 'movie_list';
  static SharedPreferences? _prefs;

  Future<SharedPreferences> get prefs async {
    if (_prefs != null) return _prefs!;
    _prefs = await SharedPreferences.getInstance();
    return _prefs!;
  }

  // Initialize the storage
  Future<void> init() async {
    await prefs;
  }

  // Insert a single movie
  Future<void> insertMovie(Movie movie) async {
    final movies = await getAllMovies();
    final existingIndex = movies.indexWhere((m) => m.id == movie.id);

    if (existingIndex != -1) {
      movies[existingIndex] = movie;
    } else {
      movies.add(movie);
    }

    await _saveMovies(movies);
  }

  // Insert multiple movies
  Future<void> insertMovies(List<Movie> newMovies) async {
    final movies = await getAllMovies();

    for (final movie in newMovies) {
      final existingIndex = movies.indexWhere((m) => m.id == movie.id);
      if (existingIndex != -1) {
        movies[existingIndex] = movie;
      } else {
        movies.add(movie);
      }
    }

    await _saveMovies(movies);
  }

  // Get all movies
  Future<List<Movie>> getAllMovies() async {
    final sp = await prefs;
    final String? moviesJson = sp.getString(_movieListKey);

    if (moviesJson == null) return [];

    final List<dynamic> decoded = json.decode(moviesJson);
    return decoded.map((item) => Movie.fromMap(item)).toList();
  }

  // Search movies
  Future<List<Movie>> searchMovies({
    String? query,
    String? genre,
    double? minRating,
    String? releaseYear,
  }) async {
    List<Movie> movies = await getAllMovies();

    return movies.where((movie) {
      bool matches = true;

      if (query != null && query.isNotEmpty) {
        matches = matches && (
            movie.title.toLowerCase().contains(query.toLowerCase()) ||
                movie.originalTitle.toLowerCase().contains(query.toLowerCase())
        );
      }

      if (genre != null) {
        matches = matches && movie.genreIds.contains(int.parse(genre));
      }

      if (minRating != null) {
        matches = matches && movie.voteAverage >= minRating;
      }

      if (releaseYear != null) {
        matches = matches && movie.releaseDate.startsWith(releaseYear);
      }

      return matches;
    }).toList()
      ..sort((a, b) => b.popularity.compareTo(a.popularity));
  }

  // Delete movie
  Future<void> deleteMovie(int id) async {
    final movies = await getAllMovies();
    movies.removeWhere((movie) => movie.id == id);
    await _saveMovies(movies);
  }

  // Clear all movies
  Future<void> clearMovies() async {
    final sp = await prefs;
    await sp.remove(_movieListKey);
  }

  // Helper method to save movies list
  Future<void> _saveMovies(List<Movie> movies) async {
    final sp = await prefs;
    final String encoded = json.encode(
        movies.map((movie) => movie.toMap()).toList()
    );
    await sp.setString(_movieListKey, encoded);
  }

  // Clear preferences
  Future<void> close() async {
    _prefs = null;
  }
}