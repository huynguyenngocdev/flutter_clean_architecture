import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/src/modules/home/domain/repositories/film_repository.dart';

part 'film_event.dart';
part 'film_state.dart';

class FilmBloc extends Bloc<FilmEvent, FilmState> {
  final FilmRepository _filmRepository;
  FilmBloc(this._filmRepository) : super(FilmInitial.initial()) {
    on<FilmLoadStartedEvent>(
      _onLoadStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<FilmLoadMoreStartedEvent>(
      _onLoadMoreStarted,
      transformer: (events, mapper) => events.switchMap(mapper),
    );
    on<FilmSelectChangedEvent>(_onSelectChanged);
  }
}


  void _onLoadStarted(PokemonLoadStarted event, Emitter<PokemonState> emit) async {
    try {
      emit(state.asLoading());

      final pokemons = event.loadAll
          ? await _pokemonRepository.getAllPokemons()
          : await _pokemonRepository.getPokemons(page: 1, limit: pokemonsPerPage);

      final canLoadMore = pokemons.length >= pokemonsPerPage;

      emit(state.asLoadSuccess(pokemons, canLoadMore: canLoadMore));
    } on Exception catch (e) {
      emit(state.asLoadFailure(e));
    }
  }

  void _onLoadMoreStarted(PokemonLoadMoreStarted event, Emitter<PokemonState> emit) async {
    try {
      if (!state.canLoadMore) return;

      emit(state.asLoadingMore());

      final pokemons = await _pokemonRepository.getPokemons(
        page: state.page + 1,
        limit: pokemonsPerPage,
      );

      final canLoadMore = pokemons.length >= pokemonsPerPage;

      emit(state.asLoadMoreSuccess(pokemons, canLoadMore: canLoadMore));
    } on Exception catch (e) {
      emit(state.asLoadMoreFailure(e));
    }
  }

  void _onSelectChanged(PokemonSelectChanged event, Emitter<PokemonState> emit) async {
    try {
      final pokemonIndex = state.pokemons.indexWhere(
        (pokemon) => pokemon.number == event.pokemonId,
      );

      if (pokemonIndex < 0 || pokemonIndex >= state.pokemons.length) return;

      final pokemon = await _pokemonRepository.getPokemon(event.pokemonId);

      if (pokemon == null) return;

      emit(state.copyWith(
        pokemons: state.pokemons..setAll(pokemonIndex, [pokemon]),
        selectedPokemonIndex: pokemonIndex,
      ));
    } on Exception catch (e) {
      emit(state.asLoadMoreFailure(e));
    }
  }
}
