import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:cinemapedia/infrastructure/datasources/isar_datasource.dart";
import "package:cinemapedia/infrastructure/repositories/local_storage_repository_impl.dart";

//! Une la implementación del repositorio (LocalStorageRepositoryImpl) con la implementación del datasource (IsarDatasource)

final localStorageRepositoryProvider = Provider((ref) {
  return LocalStorageRepositoryImpl(IsarDatasource());
});
