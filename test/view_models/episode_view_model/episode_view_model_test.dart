
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/core/exceptions/exceptions.dart';
import 'package:rick_and_morty_app/core/exceptions/failures.dart';
import 'package:rick_and_morty_app/core/network/network_info.dart';
import 'package:rick_and_morty_app/services/episode_service/episode_service.dart';
import 'package:rick_and_morty_app/view_model/character_view_model/character_view_model.dart';
import 'package:rick_and_morty_app/view_model/episode_view_model/episode_view_model.dart';

import '../../values/values_test.dart';

class MockEpisodeService extends Mock implements EpisodeService {}
class MockNetworkInfo extends Mock implements NetworkInfo {}
void main() {
  late EpisodeViewModelImpl repository;
  late MockEpisodeService mockEpisodeService;
  late MockNetworkInfo mockNetworkInfo;
  const listOfEpisodes = EpisodeModelValues.episodes;
  setUp((){
    mockEpisodeService = MockEpisodeService();
    mockNetworkInfo = MockNetworkInfo();
    repository = EpisodeViewModelImpl(service: mockEpisodeService, networkInfo: mockNetworkInfo);
  });

  void runTestOnline(Function body){
    group("device is online", (){
      setUp((){
        when(() => mockNetworkInfo.isConnected()).thenAnswer((_) async => true);
      });
      body();
    });
  }

  void runTestOffline(Function body){
    group("device is offline", (){
      setUp((){
        when(() => mockNetworkInfo.isConnected()).thenAnswer((_) async => false);
      });
      body();
    });
  }

  group("fetchEpisodesListFromAPI", (){
    List<int> listOfIds = [1,2];
    runTestOnline((){
      test("should return remote data when the call to API is success", () async {
        when(() => mockEpisodeService.fetchEpisodesList(any())).thenAnswer((_) async => listOfEpisodes);
        final result = await repository.fetchEpisodesList(listOfIds);
        verify(() => mockEpisodeService.fetchEpisodesList(listOfIds));
        expect(result, equals(const Right(listOfEpisodes)));
      });

      test("should return ServerFailure when the call to API is unsuccess", () async {
        when(() => mockEpisodeService.fetchEpisodesList(any())).thenThrow(ServerException());
        final result = await repository.fetchEpisodesList(listOfIds);
        verify(() => mockEpisodeService.fetchEpisodesList(listOfIds));
        expect(result, equals(Left(ServerFailure())));
      });
    });
    runTestOffline((){
      test("should return InternetFailure when isConnected == false", () async {
        final result = await repository.fetchEpisodesList(listOfIds);
        verifyZeroInteractions(mockEpisodeService);
        expect(result, equals(Left(InternetFailure())));
      });
    });
  });
}