import 'package:equatable/equatable.dart';

abstract class CharacterBlocEvent extends Equatable {}

class GetCharacterByNameEvent extends CharacterBlocEvent {
  final String name;
  GetCharacterByNameEvent({required this.name});
  @override
  List<Object?> get props => [name];
}

class GetCharacterListEvent extends CharacterBlocEvent {
  
  @override
  List<Object?> get props => [];
}

class FindCharacterByIdEvent extends CharacterBlocEvent{
  final List<int> id;
  FindCharacterByIdEvent({required this.id});
  @override
  List<Object?> get props => [id];
  
}

class ResetBlocEvent extends CharacterBlocEvent{
  @override
  List<Object?> get props => [];
  
}