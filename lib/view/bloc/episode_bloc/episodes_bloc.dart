import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/view/bloc/episode_bloc/episodes_bloc_event.dart';
import 'package:rick_and_morty_app/view/bloc/episode_bloc/episodes_bloc_state.dart';
import 'package:rick_and_morty_app/view_model/episode_view_model/episode_view_model.dart';
class EpisodesBloc extends Bloc<EpisodesBlocEvent, EpisodesBlocState>{
  final EpisodeViewModel episodeViewModel;
  EpisodesBloc({required this.episodeViewModel}): super(InitState()){
    on<FetchListOfEpisodes>(_mapEventToState);
  }

  Future<void> _mapEventToState(FetchListOfEpisodes event, Emitter<EpisodesBlocState> emmit) async {
    emmit(LoadingState());
    final data = await episodeViewModel.fetchEpisodesList(event.episodes); 
    data.fold((failure) => emmit(ErrorState(failure: failure)),
          (characters) => emmit(EpisodesLoadedState(episodes: characters)));
  }

}