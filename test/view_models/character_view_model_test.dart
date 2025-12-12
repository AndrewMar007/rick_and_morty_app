
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mocktail/mocktail.dart';
import 'package:rick_and_morty_app/core/exceptions/exceptions.dart';
import 'package:rick_and_morty_app/core/exceptions/failures.dart';
import 'package:rick_and_morty_app/core/network/network_info.dart';
import 'package:rick_and_morty_app/services/character_service/character_service.dart';
import 'package:rick_and_morty_app/view_model/character_view_model/character_view_model.dart';

import '../values/values_test.dart';

class MockCharacterService extends Mock implements CharacterService {}
class MockNetworkInfo extends Mock implements NetworkInfo {}
void main() {
  late CharacterViewModelImpl repository;
  late MockCharacterService mockCharacterService;
  late MockNetworkInfo mockNetworkInfo;
  const listOfCharacters = CharacterModelValues.listOfCharacters;
  const characterIdList = CharacterModelValues.idList;
  const characterName = "rick";

  setUp((){
    mockCharacterService = MockCharacterService();
    mockNetworkInfo = MockNetworkInfo();
    repository = CharacterViewModelImpl(service: mockCharacterService, networkInfo: mockNetworkInfo);
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

  group("fetchCharacterListFromAPI", (){
    runTestOnline((){
      test("should return remote data when the call to API is success", () async {
        when(() => mockCharacterService.fetchListOfCharacters(any())).thenAnswer((_) async => listOfCharacters);
        final result = await repository.fetchListOfCharacters(1);
        verify(() => mockCharacterService.fetchListOfCharacters(1));
        expect(result, equals(const Right(listOfCharacters)));
      });

      test("should return ServerFailure when the call to API is unsuccess", () async {
        when(() => mockCharacterService.fetchListOfCharacters(any())).thenThrow(ServerException());
        final result = await repository.fetchListOfCharacters(1);
        verify(() => mockCharacterService.fetchListOfCharacters(1));
        expect(result, equals(Left(ServerFailure())));
      });
    });
    runTestOffline((){
      test("should return InternetFailure when isConnected == false", () async {
        final result = await repository.fetchListOfCharacters(1);
        verifyZeroInteractions(mockCharacterService);
        expect(result, equals(Left(InternetFailure())));
      });
    });
  });

  group("fetchCharacterByNameFromAPI", (){
    runTestOnline((){
      test("should return remote data when the call to API is success", () async {
        when(() => mockCharacterService.fetchCharacterByName(any())).thenAnswer((_) async => listOfCharacters);
        final result = await repository.fetchCharacterByName(characterName);
        verify(() => mockCharacterService.fetchCharacterByName(characterName));
        expect(result, equals(const Right(listOfCharacters)));
      });

      test("should return ServerException when the call to API is unsuccess", () async {
        when(() => mockCharacterService.fetchCharacterByName(any())).thenThrow(ServerException());
        final result = await repository.fetchCharacterByName(characterName);
        verify(() => mockCharacterService.fetchCharacterByName(characterName));
        expect(result, equals(Left(ServerFailure())));
      });
    });
    runTestOffline((){
      test("should return InternetFailure when isConnected == false", () async {
        final result = await repository.fetchCharacterByName(characterName);
        verifyZeroInteractions(mockCharacterService);
        expect(result, equals(Left(InternetFailure())));
      });
    });
  });

  group("findCharacterById", (){
    runTestOnline((){
      test("should return remote data when the call to API is success", () async {
        when(() => mockCharacterService.findCharacterById(any())).thenAnswer((_) async => listOfCharacters);
        final result = await repository.findCharacterById(characterIdList);
        verify(() => mockCharacterService.findCharacterById(characterIdList));
        expect(result, equals(const Right(listOfCharacters)));
      });

      test("should return ServerException when the call to API is unsuccess", () async {
        when(() => mockCharacterService.findCharacterById(any())).thenThrow(ServerException());
        final result = await repository.findCharacterById(characterIdList);
        verify(() => mockCharacterService.findCharacterById(characterIdList));
        expect(result, equals(Left(ServerFailure())));
      });
    });

    runTestOffline((){
      test("should return InternetFailure when isConnected == false", () async {
        final result = await repository.findCharacterById(characterIdList);
        verifyZeroInteractions(mockCharacterService);
        expect(result, equals(Left(InternetFailure())));
      });
    });
  });
}