import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/src/modules/home/data/mappers/fiml_mapper.dart';
import 'package:flutter_clean_architecture/src/modules/home/domain/entities/film_entity.dart';
import 'package:flutter_clean_architecture/src/modules/home/domain/usecases/film_usecases.dart';

part 'film_event.dart';
part 'film_state.dart';

class FilmBloc extends Bloc<FilmEvent, FilmState> {
  final FetchFilmUseCase _filmUseCase;
  FilmBloc(this._filmUseCase) : super(const FilmState.initial()) {
    on<FetchFilmsEvent>(
      _onLoad,
    );
  }

  void _onLoad(FetchFilmsEvent event, Emitter<FilmState> emit) async {
    try {
      emit(state.asLoading());

      final films = await _filmUseCase.call();
      List<FilmEntity> mapToFilmEntity = [];

      films.map(
        (e) => mapToFilmEntity.add(
          FilmMapper().mapperTo(e),
        ),
      );

      emit(state.asLoadSuccess(mapToFilmEntity));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }
}
