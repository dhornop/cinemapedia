import "package:cinemapedia/domain/entities/movie.dart";

//! Datasource para acceder a la información de la base de datos local

abstract class LocalStorageDatasource {
  Future<void> toggleFavorite(Movie movie);

  Future<bool> isMovieFavorite(int movieId);

  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
