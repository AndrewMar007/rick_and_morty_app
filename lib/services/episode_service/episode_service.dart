import 'package:dio/dio.dart';
import 'package:rick_and_morty_app/core/api_config/api_config.dart';
import 'package:rick_and_morty_app/core/exceptions/exceptions.dart';
import 'package:rick_and_morty_app/model/episode_model.dart';

abstract class EpisodeService {
  Future<List<EpisodeModel>> fetchEpisodesList(List<int> episodes);
}

class EpisodeServiceImpl extends EpisodeService {
  final Dio client;
  EpisodeServiceImpl({required this.client});

  @override
  Future<List<EpisodeModel>> fetchEpisodesList(List<int> episodes) async {
    List<EpisodeModel> list = [];
    List<dynamic> dynamicList = [];
    String convertedList = episodes.join(",");
    final response = await client
        .get("${ApiConfig.episodes}/$convertedList");
    if (response.statusCode == 200) {
      final data = response.data;
      if (data is List<dynamic>) {
        list = data.map((e) => EpisodeModel.fromJson(e)).toList();
      } else {
        dynamicList.add(data);
        list = dynamicList.map((e) => EpisodeModel.fromJson(e)).toList();
      }
      return list;
    } else {
      throw ServerException();
    }
  }
}
