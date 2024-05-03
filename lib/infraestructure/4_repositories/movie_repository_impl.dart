import 'package:cinemapedia/domain/1_entities/movie.dart';
import 'package:cinemapedia/domain/2_datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/3_repositories/movies_repository.dart';

class MovieRepositoryImpl extends MoviesRepository {
  //!Variables
  final MoviesDatasource datasource;

  //!Constructor
  MovieRepositoryImpl({required this.datasource});

  //!Métodos
  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    return datasource.getNowPlaying(page: page);
  }

  @override
  Future<List<Movie>> getPopular({int page = 1}) {
    return datasource.getPopular(page: page);
  }

  @override
  Future<List<Movie>> getTopRated({int page = 1}) {
    return datasource.getTopRated(page: page);
  }

  @override
  Future<List<Movie>> getUpcoming({int page = 1}) {
    return datasource.getUpcoming(page: page);
  }
}
