import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/core/api_config/api_config.dart';
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

  Future<List<CharacterModel>> _fetchCharacters(
      Map<String, dynamic> queryParameters) async {
    try {
      final response =
          await client.get(ApiConfig.characters, queryParameters: queryParameters);
      if (response.statusCode == 200) {
        final data = response.data["results"];
        List<CharacterModel> list =
            (data as List).map((e) => CharacterModel.fromJson(e)).toList();
        return list;
      } else {
        throw ServerException();
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        return <CharacterModel>[];
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<List<CharacterModel>> fetchCharacterByName(String name) async {
    return _fetchCharacters({"name": name});
  }

  @override
  Future<List<CharacterModel>> fetchListOfCharacters(int page) async {
   return _fetchCharacters({"page": page});
  }

  @override
  Future<List<CharacterModel>> findCharacterById(List<int> id) async {
    String convertedList = id.join(",");
    final response = await client
        .get("${ApiConfig.characters}/$convertedList");
    if (response.statusCode == 200) {
      final data = response.data;
      List<CharacterModel> list =
          (data as List).map((e) => CharacterModel.fromJson(e)).toList();
      return list;
    } else {
      throw ServerException();
    }
  }
}
