import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:rick_and_morty_app/core/api_config/api_config.dart';
import 'package:rick_and_morty_app/core/network/network_info.dart';
import 'package:rick_and_morty_app/services/character_service/character_service.dart';
import 'package:rick_and_morty_app/services/episode_service/episode_service.dart';
import 'package:rick_and_morty_app/view_model/character_view_model/character_view_model.dart';
import 'package:rick_and_morty_app/view_model/episode_view_model/episode_view_model.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton<CharacterViewModel>(
      () => CharacterViewModelImpl(service: sl(), networkInfo: sl()));
  sl.registerLazySingleton<EpisodeViewModel>(
      () => EpisodeViewModelImpl(networkInfo: sl(), service: sl()));
  sl.registerLazySingleton<EpisodeService>(
      () => EpisodeServiceImpl(client: sl()));
  sl.registerLazySingleton<CharacterService>(
      () => CharacterServiceImpl(client: sl()));
  sl.registerLazySingleton(() => Dio(BaseOptions(
    baseUrl: ApiConfig.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10)
  )));
}
