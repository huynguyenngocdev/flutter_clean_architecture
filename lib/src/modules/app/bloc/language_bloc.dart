import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState(localeCodeProvider: 'en')) {
    on<UpdateLocaleCodeEvent>((event, emit) {
      emit(state.copyWith(localeCodeProvider: event.localeCode));
    });
  }
}
