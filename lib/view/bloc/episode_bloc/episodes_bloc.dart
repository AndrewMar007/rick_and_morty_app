import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/view/bloc/episode_bloc/episodes_bloc_event.dart';
import 'package:rick_and_morty_app/view/bloc/episode_bloc/episodes_bloc_state.dart';
import 'package:rick_and_morty_app/view_model/episode_view_model/episode_view_model.dart';

import '../../../core/exceptions/failures.dart';

class EpisodesBloc extends Bloc<EpisodesBlocEvent, EpisodesBlocState>{
  final EpisodeViewModel episodeViewModel;
  EpisodesBloc({required this.episodeViewModel}): super(InitState()){
    on<FetchListOfEpisodes>(_mapEventToState);
  }

  Future<void> _mapEventToState(FetchListOfEpisodes event, Emitter<EpisodesBlocState> emmit) async {
    emmit(LoadingState());
    final data = await episodeViewModel.fetchEpisodesList(event.episodes); 
    data.fold((failure) => emmit(ErrorState(error: FailureMessage().mapFailureToMessage(failure))),
          (characters) => emmit(EpisodesLoadedState(episodes: characters)));
  }

}

class FailureMessage{
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