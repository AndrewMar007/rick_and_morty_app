import 'package:equatable/equatable.dart';

abstract class EpisodesBlocEvent extends Equatable{}

class FetchListOfEpisodes extends EpisodesBlocEvent{
  final List<int> episodes;
  FetchListOfEpisodes({required this.episodes});
  @override
  List<Object?> get props => throw UnimplementedError();
  
}