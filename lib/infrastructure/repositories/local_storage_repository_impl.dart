import "package:cinemapedia/domain/entities/movie.dart";
import "package:cinemapedia/domain/datasources/local_storage_datasource.dart";
import "package:cinemapedia/domain/repositories/local_storage_repository.dart";

//! Implementación del repository para acceder a la información de la base de datos local
//? Este repositorio no lleva el nombre de la base de datos (Isar) porque podríamos implementar en él diferentes bases de datos locales

class LocalStorageRepositoryImpl extends LocalStorageRepository {
  final LocalStorageDatasource datasource;

  LocalStorageRepositoryImpl(this.datasource);

  @override
  // Método para alternar el estado de favorito de una película
  Future<void> toggleFavorite(Movie movie) {
    return datasource.toggleFavorite(movie);
  }

  @override
  // Método para verificar si una película es favorita
  Future<bool> isMovieFavorite(int movieId) {
    return datasource.isMovieFavorite(movieId);
  }

  @override
  // Método para cargar las películas favoritas
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) {
    return datasource.loadMovies(limit: limit, offset: offset);
  }
}
