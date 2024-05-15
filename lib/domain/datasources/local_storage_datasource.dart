import "package:cinemapedia/domain/entities/movie.dart";

//! Datasource para acceder a la información de la base de datos local

abstract class LocalStorageDatasource {
  // Método para alternar el estado de favorito de una película
  Future<void> toggleFavorite(Movie movie);

  // Método para verificar si una película es favorita
  Future<bool> isMovieFavorite(int movieId);

  // Método para cargar las películas favoritas
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0});
}
