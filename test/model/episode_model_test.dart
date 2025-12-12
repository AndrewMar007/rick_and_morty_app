import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_app/model/episode_model.dart';

import '../fixtures/fixtures_reader.dart';

void main() {
  EpisodeModel tEpsiodeModel = EpisodeModel(
      id: 28,
      name: "The Ricklantis Mixup",
      airDate: "September 10, 2017",
      episode: "S03E07",
      characters: [
        "https://rickandmortyapi.com/api/character/1",
        "https://rickandmortyapi.com/api/character/2",
      ],
      url: "https://rickandmortyapi.com/api/episode/28",
      created: "2017-11-10T12:56:36.618Z");

      group("fromJson", (){
        test("should return a valid model when JSON isRight", (){
          final Map<String, dynamic> jsonMap = json.decode(fixture('episode.json'));
          final result = EpisodeModel.fromJson(jsonMap);
          expect(result, tEpsiodeModel);
        });
      });
}
