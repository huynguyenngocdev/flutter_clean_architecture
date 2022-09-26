import 'package:flutter_clean_architecture/src/core/usecase.dart';
import 'package:flutter_clean_architecture/src/modules/home/data/models/film_model.dart';
import 'package:flutter_clean_architecture/src/modules/home/domain/repositories/film_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchFilmUseCase extends NoParamsUseCase<List<FilmModel>> {
  const FetchFilmUseCase(this.filmRepository);

  final FilmRepository filmRepository;

  @override
  Future<List<FilmModel>> call() {
    return filmRepository.fetchFilms();
  }
}
