import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/core/exceptions/exceptions.dart';
import 'package:rick_and_morty_app/model/character_model.dart';

abstract class CharacterService {
  Future<List<CharacterModel>> fetchListOfCharacters(int page);
  Future<List<CharacterModel>> fetchCharacterByName(String name);
  Future<List<CharacterModel>> findCharacterById(List<int> id);
}

class CharacterServiceImpl extends CharacterService {
  final Dio client;
  CharacterServiceImpl({required this.client});

  @override
  Future<List<CharacterModel>> fetchCharacterByName(String name) async {
    final response = await client.get("https://rickandmortyapi.com/api/character/?name=$name");
    if(response.statusCode == 200){
      final data = response.data["results"];
      List<CharacterModel> list = (data as List)
        .map((e) => CharacterModel.fromJson(e))
        .toList();
        return list;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<CharacterModel>> fetchListOfCharacters(int page) async {
    final response = await client.get(
        "https://rickandmortyapi.com/api/character/?page=$page");
       
    if (response.statusCode == 200) {
      final data = response.data["results"];
      List<CharacterModel> list = (data as List)
        .map((e) => CharacterModel.fromJson(e))
        .toList();
        return list;
    } else {
      throw ServerException();
    }
  }
  
  @override
  Future<List<CharacterModel>> findCharacterById(List<int> id) async {
        String convertedList = id.join(",");
    final response = await client.get("https://rickandmortyapi.com/api/character/$convertedList");
    if(response.statusCode == 200){
      final data = response.data;
      List<CharacterModel> list = (data as List)
        .map((e) => CharacterModel.fromJson(e))
        .toList();
        return list;
    } else {
      throw ServerException();
    }
  }
}
