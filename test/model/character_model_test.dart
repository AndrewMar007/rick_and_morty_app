import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_app/model/character_model.dart';

import '../fixtures/fixtures_reader.dart';
import '../values/values_test.dart';

void main() {
  CharacterModel tCharacterModel = const CharacterModel(
      id: 2,
      name: "Morty Smith",
      status: "Alive",
      species: "Human",
      type: "",
      gender: "Male",
      image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
      location: CharacterModelValues.location,
      episode: [
        "https://rickandmortyapi.com/api/episode/1",
        "https://rickandmortyapi.com/api/episode/2"
      ],
      url: "https://rickandmortyapi.com/api/character/2",
      created: "2017-11-04T18:50:21.651Z");
  group("fromJson", () {
    test("should return a valid model when JSON isRight", () async {
      final Map<String, dynamic> jsonMap = json.decode(fixture('character.json'));
      final result = CharacterModel.fromJson(jsonMap);
      expect(result, tCharacterModel);
    });
  });
}
