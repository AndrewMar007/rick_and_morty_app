import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/view/bloc/character_bloc/character_bloc_event.dart';
import 'package:rick_and_morty_app/view/bloc/character_bloc/character_bloc_state.dart';
import 'package:rick_and_morty_app/view_model/character_view_model/character_view_model.dart';

import '../../../core/exceptions/failures.dart';
import '../../../model/character_model.dart';

const String serverFailureMessage = 'Server Failure';
const String internetFailureMessage = 'No internet connection';

class CharacterBlocList extends Bloc<CharacterBlocEvent, CharacterBlocState> {
  final CharacterViewModel characterViewModel;

  final List<CharacterModel> _allCharacters = [];
  int _page = 1;
  bool _isFetching = false;
  bool _hasMore = true;

  CharacterBlocList({required this.characterViewModel}) : super(InitState()) {
    on<GetCharacterListEvent>(_onGetCharacterList);
    on<GetCharacterByNameEvent>(_onGetCharacterByName);
  }

  Future<void> _onGetCharacterList(
    GetCharacterListEvent event,
    Emitter<CharacterBlocState> emit,
  ) async {
    if (_isFetching || !_hasMore) return;

    _isFetching = true;

    if (_page == 1 && _allCharacters.isEmpty) {
      emit(LoadingState());
    }

    final data = await characterViewModel.fetchListOfCharacters(_page);

    data.fold(
      (failure) {
        _isFetching = false;
        emit(ErrorState(error: FailureMessage().mapFailureToMessage(failure)));
      },
      (charactersPage) {
        _allCharacters.addAll(charactersPage);

        if (charactersPage.isEmpty || charactersPage.length < 15) {
          _hasMore = false;
        } else {
          _page++;
        }

        _isFetching = false;

        emit(
          FetchListOfCharactersLoadedState(
            characterModelList: List.unmodifiable(_allCharacters),
            hasMore: _hasMore,
          ),
        );
      },
    );
  }

  Future<void> _onGetCharacterByName(
      GetCharacterByNameEvent event, Emitter<CharacterBlocState> emmit) async {
    emmit(LoadingState());
    final data = await characterViewModel.fetchCharacterByName(event.name);
    data.fold(
        (failure) => emmit(
            ErrorState(error: FailureMessage().mapFailureToMessage(failure))),
        (characters) =>
            emmit(FetchCharacterByNameLoadedState(charactersList: characters)));
  }
}

class CharacterBlocFindByName
    extends Bloc<CharacterBlocEvent, CharacterBlocState> {
  final CharacterViewModel characterViewModel;
  CharacterBlocFindByName({required this.characterViewModel})
      : super(InitState()) {
    on<GetCharacterByNameEvent>(_onGetCharacterByName);
    on<ResetBlocEvent>((event, emit) => emit(InitState()));
  }
  Future<void> _onGetCharacterByName(
      GetCharacterByNameEvent event, Emitter<CharacterBlocState> emmit) async {
    emmit(LoadingState());
    final data = await characterViewModel.fetchCharacterByName(event.name);
    data.fold(
        (failure) => emmit(
            ErrorState(error: FailureMessage().mapFailureToMessage(failure))),
        (characters) =>
            emmit(FetchCharacterByNameLoadedState(charactersList: characters)));
  }
}

class CharacterBlocFindById
    extends Bloc<CharacterBlocEvent, CharacterBlocState> {
  final CharacterViewModel characterViewModel;
  CharacterBlocFindById({required this.characterViewModel})
      : super(InitState()) {
    on<FindCharacterByIdEvent>(_onFindCharacterById);
  }
  Future<void> _onFindCharacterById(
      FindCharacterByIdEvent event, Emitter<CharacterBlocState> emmit) async {
    emmit(LoadingState());
    final data = await characterViewModel.findCharacterById(event.id);
    data.fold(
        (failure) => emmit(
            ErrorState(error: FailureMessage().mapFailureToMessage(failure))),
        (characters) => emmit(FindCharacterByIdLoadedState(model: characters)));
  }
}

class FailureMessage {
  String mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case const (ServerFailure):
        return serverFailureMessage;
      case const (InternetFailure):
        return internetFailureMessage;
      default:
        return "Unexpected Error";
    }
  }
}
