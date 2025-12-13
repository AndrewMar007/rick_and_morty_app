import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:rick_and_morty_app/model/episode_model.dart';

import '../fixtures/fixtures_reader.dart';
import '../values/values_test.dart';

void main() {
      const tEpsiodeModel = EpisodeModelValues.episode;

      group("fromJson", (){
        test("should return a valid model when JSON isRight", (){
          final Map<String, dynamic> jsonMap = json.decode(fixture('episode.json'));
          final result = EpisodeModel.fromJson(jsonMap);
          expect(result, tEpsiodeModel);
        });
      });
}
