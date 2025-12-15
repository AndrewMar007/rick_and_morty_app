import 'package:equatable/equatable.dart';

import '../../../core/exceptions/failures.dart';
import '../../../model/character_model.dart';

abstract class CharacterBlocState extends Equatable {}

class InitState extends CharacterBlocState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends CharacterBlocState {
  @override
  List<Object?> get props => [];
}

class FetchCharacterByNameLoadedState extends CharacterBlocState {
  final List<CharacterModel> charactersList;
  FetchCharacterByNameLoadedState({required this.charactersList});

  @override
  List<Object?> get props => [charactersList];
}

class FetchListOfCharactersLoadedState extends CharacterBlocState {
  final List<CharacterModel> characterModelList;
  final bool hasMore;

  FetchListOfCharactersLoadedState({
    required this.characterModelList,
    required this.hasMore,
  });

  @override
  List<Object?> get props => [characterModelList, hasMore];
}

class FindCharacterByIdLoadedState extends CharacterBlocState{
  final List<CharacterModel> list;
  FindCharacterByIdLoadedState({required this.list}); 
  @override
  List<Object?> get props => [list];
  
}

class ErrorState extends CharacterBlocState{
  final Failure failure;
  ErrorState({required this.failure});
  @override
  List<Object?> get props => [failure];
  
}
