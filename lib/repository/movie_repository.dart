import '../models/movie_model.dart';
import '../services/api_service.dart';
import '../services/database_service.dart';

class MovieRepository {
  final MovieApiService apiService;
  final MovieDatabaseService databaseService;

  MovieRepository({
    required this.apiService,
    required this.databaseService,
  });

  Future<List<Movie>> getMovies() async {
    try {
      final movies = await apiService.getPopularMovies();
      await databaseService.insertMovies(movies);
      return movies;
    } catch (e) {
      final movies = await databaseService.getAllMovies();
      if (movies.isEmpty) {
        throw Exception('Failed to fetch movies');
      }
      return movies;
      // throw Exception('Failed to fetch movies');
    }
  }
}