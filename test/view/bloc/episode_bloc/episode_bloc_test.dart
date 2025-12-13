import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/core/exceptions/failures.dart';
import 'package:rick_and_morty_app/view/bloc/episode_bloc/episodes_bloc.dart';
import 'package:rick_and_morty_app/view/bloc/episode_bloc/episodes_bloc_event.dart';
import 'package:rick_and_morty_app/view/bloc/episode_bloc/episodes_bloc_state.dart';
import 'package:rick_and_morty_app/view_model/episode_view_model/episode_view_model.dart';

import '../../../values/values_test.dart';

class MockEpisodeViewModel extends Mock implements EpisodeViewModel {}

void main() {
  late EpisodesBloc episodesBloc;
  late MockEpisodeViewModel mockEpisodeViewModel;
  setUp(() {
    mockEpisodeViewModel = MockEpisodeViewModel();
    episodesBloc = EpisodesBloc(episodeViewModel: mockEpisodeViewModel);
  });

  group("PeisodesBloc", () {
    const listOfEpisodes = EpisodeModelValues.episodes;
    List<int> episodesIds = [1, 2, 3];
    test("inital state should be InitState", () {
      expect(episodesBloc.state, isA<InitState>());
    });
    test("should get data for FetchListOfEpisodesEvent", () async {
      when(() => mockEpisodeViewModel.fetchEpisodesList(any()))
          .thenAnswer((_) async => const Right(listOfEpisodes));
      episodesBloc.add(FetchListOfEpisodes(episodes: episodesIds));
      await untilCalled(() => mockEpisodeViewModel.fetchEpisodesList(any()));
      verify(() => mockEpisodeViewModel.fetchEpisodesList(episodesIds));
    });
    blocTest(
      "should emit [LoadingState, EpisodesLoadedState] when getting data success",
      build: () => EpisodesBloc(episodeViewModel: mockEpisodeViewModel),
      act: (bloc) {
        when(() => mockEpisodeViewModel.fetchEpisodesList(any()))
            .thenAnswer((_) async => const Right(listOfEpisodes));
        bloc.add(FetchListOfEpisodes(episodes: episodesIds));
      },
      expect: () => [
        isA<LoadingState>(),
        isA<EpisodesLoadedState>()
            .having((s) => s.episodes, "epsiodes", listOfEpisodes)
      ],
    );
    blocTest("should emit [LoadingState, ErrorState] when getting data failed",
        build: () => EpisodesBloc(episodeViewModel: mockEpisodeViewModel),
        act: (bloc) {
          when(() => mockEpisodeViewModel.fetchEpisodesList(any()))
              .thenAnswer((_) async => Left(ServerFailure()));
          bloc.add(FetchListOfEpisodes(episodes: episodesIds));
        },
        expect: () => [isA<LoadingState>(), isA<ErrorState>()]);
  });
}
