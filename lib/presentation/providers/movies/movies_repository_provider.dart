import 'package:cinemapedia/infraestructure/3_datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infraestructure/4_repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//Este repositorio es inmutable
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImpl(datasource: MovieDbDatasource());
});
