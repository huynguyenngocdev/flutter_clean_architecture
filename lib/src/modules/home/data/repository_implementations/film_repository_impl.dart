import 'package:flutter_clean_architecture/src/core/error_handles/app_error.dart';
import 'package:flutter_clean_architecture/src/core/mapper/exception_mapper.dart';
import 'package:flutter_clean_architecture/src/modules/home/data/models/models.dart';
import 'package:flutter_clean_architecture/src/modules/home/data/remote_source/api/film_api.dart';
import 'package:flutter_clean_architecture/src/modules/home/domain/repositories/film_repository.dart';

class FilmRepositoryImpl implements FilmRepository {
  final FilmAPI filmAPI;
  final ExceptionMapper _exceptionMapper;

  FilmRepositoryImpl(this.filmAPI, String languageCode,
      {String? apiKey, ExceptionMapper? mapper})
      : _exceptionMapper =
            mapper ?? ExceptionMapper(languageCode: languageCode);

  @override
  Future<List<FilmModel>> fetchFilms() async {
    final response = await filmAPI.fetchFilms().catchError(
        (e) async => throw await _exceptionMapper.mapperTo(AppError.from(e)));
    return response.films ?? [];
  }
}
