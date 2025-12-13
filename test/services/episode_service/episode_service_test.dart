import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/core/exceptions/exceptions.dart';
import 'package:rick_and_morty_app/model/episode_model.dart';
import 'package:rick_and_morty_app/services/episode_service/episode_service.dart';

import '../../fixtures/fixtures_reader.dart';
import '../../values/values_test.dart';

class MockDioClient extends Mock implements Dio {}

void main() {
  late EpisodeService service;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    service = EpisodeServiceImpl(client: mockDioClient);
  });
  
  void setUpMockDioClientSuccess200(String fixtureString) {
    when(() => mockDioClient.get(any())).thenAnswer((_) async => Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 200,
        data: json.decode(fixture(fixtureString))
        ));
  }

  void setUpMockDioClientFailure404() {
    when(() => mockDioClient.get(any())).thenAnswer((_) async => Response(
        requestOptions: RequestOptions(path: ''),
        statusCode: 404,
        data: {"message" : "Something went wrong"}));
  }

  group("FetchEpisodesList", (){
    const List<int> listOfIds = [1,2];
    final convertedList = listOfIds.join(",");
    List<EpisodeModel> list = EpisodeModelValues.episodes;
    List<EpisodeModel> listOfOneEpisode = [EpisodeModelValues.episode];
    const fixtureString = "episode_list.json";
    const fixtureStringForMap = "episode.json";
     test(
        "should perform a GET request on a URL with convertedList being the endpoint",
        () async {
      setUpMockDioClientSuccess200(fixtureString);
      await service.fetchEpisodesList(listOfIds);

      verify(() => mockDioClient.get("https://rickandmortyapi.com/api/episode/$convertedList"));
          
    });

    test("should return list of episodes when the response code is 200 and get list of episodes (success)" , () async {
      setUpMockDioClientSuccess200(fixtureString);
      final result = await service.fetchEpisodesList(listOfIds);
      expect(result, equals(list));
    });
     test("should return list of episodes when the response code is 200 and get only 1 record (success)" , () async {
      setUpMockDioClientSuccess200(fixtureStringForMap);
      final result = await service.fetchEpisodesList(listOfIds);
      expect(result, equals(listOfOneEpisode));
    });

    test("should throw a ServerException when the response code is 404 or other", () async {
      setUpMockDioClientFailure404();
      final call = service.fetchEpisodesList(listOfIds);
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
