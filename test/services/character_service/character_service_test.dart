import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/core/api_config/api_config.dart';
import 'package:rick_and_morty_app/core/exceptions/exceptions.dart';
import 'package:rick_and_morty_app/model/character_model.dart';
import 'package:rick_and_morty_app/services/character_service/character_service.dart';

import '../../fixtures/fixtures_reader.dart';
import '../../values/values_test.dart';

class MockDioClient extends Mock implements Dio {}

void main() {
  late CharacterService service;
  late MockDioClient mockDioClient;

  setUp(() {
    mockDioClient = MockDioClient();
    service = CharacterServiceImpl(client: mockDioClient);
  });
  
  void setUpMockDioClientSuccess200(String fixtureString, String config) {
    when(() => mockDioClient.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => Response(
        requestOptions: RequestOptions(path: config),
        statusCode: 200,
        data: json.decode(fixture(fixtureString))
        ));
  }

  void setUpMockDioClientFailure404(String config) {
    when(() => mockDioClient.get(any(), queryParameters: any(named: 'queryParameters'))).thenAnswer((_) async => Response(
        requestOptions: RequestOptions(path: config),
        statusCode: 404,
        data: {"message" : "Something went wrong"}));
  }

  group("FetchCharactersList", (){
    const int tPage = 1;
    List<CharacterModel> list = [CharacterModelValues.character];
    const fixtureString = "characters_main_list.json";
     test(
        "should perform a GET request on a URL with page index being the endpoint",
        () async {
      setUpMockDioClientSuccess200(fixtureString, ApiConfig.characters);
      await service.fetchListOfCharacters(tPage);

      verify(() => mockDioClient.get(ApiConfig.characters, queryParameters: {"page": tPage}));
          
    });

    test("should return list of characters when the response code is 200 (success)" , () async {
      setUpMockDioClientSuccess200(fixtureString, ApiConfig.characters);
      final result = await service.fetchListOfCharacters(tPage);
      expect(result, equals(list));
    });
    test("should throw a ServerException when the response code is 404 or other", () async {
      setUpMockDioClientFailure404(ApiConfig.characters);
      final call = service.fetchListOfCharacters(tPage);
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group("FetchCharacterByName", (){
    const fixtureString = "fetch_by_name.json";
    List<CharacterModel> list = [CharacterModelValues.rick];
    const characterName = "rick";

    test("should perform a GET request on a URL with characterName being the endpoint", () async {
      setUpMockDioClientSuccess200(fixtureString, ApiConfig.characters);
      await service.fetchCharacterByName(characterName);
      verify(() => mockDioClient.get(ApiConfig.characters, queryParameters: {"name": characterName}));
    });
    test("should return list of characters when the response code is 200 (success)", () async {
      setUpMockDioClientSuccess200(fixtureString, ApiConfig.characters);
      final result = await service.fetchCharacterByName(characterName);
      expect(result, equals(list));
    });
    test("should throw a ServerException when the response code is 404 or other",() async {
      setUpMockDioClientFailure404(ApiConfig.characters);
      final call = service.fetchCharacterByName(characterName);
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });

  group("FetchCharacterById", (){
    const fixtureString = "character_list.json";
    const List<int> idList = [1,2];
    test("should perform a GET request on a URL with List of characters id being the endpoint", () async {
      setUpMockDioClientSuccess200(fixtureString, ApiConfig.characters);
      await service.findCharacterById(idList);
      String idsString = idList.join(",");
      verify(() => mockDioClient.get("${ApiConfig.characters}/$idsString"));
    });

    test("should return list of characters when the response is 200 (success)", () async {
      setUpMockDioClientSuccess200(fixtureString, ApiConfig.characters);
      final result = await service.findCharacterById(idList);
      expect(result, equals(CharacterModelValues.listOfCharacters));
    });

    test("should return ServerException when the response is 404 or other", () async {
      setUpMockDioClientFailure404(ApiConfig.characters);
      final call = service.findCharacterById(idList);
      expect(() => call, throwsA(const TypeMatcher<ServerException>()));
    });
  });
}
