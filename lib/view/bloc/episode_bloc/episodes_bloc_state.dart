import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/model/episode_model.dart';

abstract class EpisodesBlocState extends Equatable{}

class InitState extends EpisodesBlocState{
  @override
  List<Object?> get props => [];
  
}

class LoadingState extends EpisodesBlocState{
  @override
  List<Object?> get props => [];
  
}

class ErrorState extends EpisodesBlocState{
  final String error;
  ErrorState({required this.error});
  @override
  List<Object?> get props => [];
  
}

class EpisodesLoadedState extends EpisodesBlocState{

  final List<EpisodeModel> episodes;
  EpisodesLoadedState({required this.episodes});
  @override
  List<Object?> get props => [episodes];
}