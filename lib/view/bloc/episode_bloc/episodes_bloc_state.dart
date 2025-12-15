import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/model/episode_model.dart';

import '../../../core/exceptions/failures.dart';

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
  final Failure failure;
  ErrorState({required this.failure});
  @override
  List<Object?> get props => [];
  
}

class EpisodesLoadedState extends EpisodesBlocState{

  final List<EpisodeModel> episodes;
  EpisodesLoadedState({required this.episodes});
  @override
  List<Object?> get props => [episodes];
}