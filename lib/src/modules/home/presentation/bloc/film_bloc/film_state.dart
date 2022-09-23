part of 'film_bloc.dart';

abstract class FilmState extends Equatable {
  const FilmState();
  
  @override
  List<Object> get props => [];
}

class FilmInitial extends FilmState {}
