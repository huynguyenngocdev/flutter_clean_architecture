import 'package:flutter_clean_architecture/src/modules/home/data/models/models.dart';

abstract class FilmRepository {
  Future<List<FilmModel>> fetchFilms();
}
