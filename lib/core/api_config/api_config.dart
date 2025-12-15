import 'package:rick_and_morty_app/core/api_config/env.dart';

class ApiConfig {
  static String get baseUrl => Env.baseUrl;

  // endpoints

  static const characters = "/character";
  static const episodes = "/episode";

  // pagination
  static const pageSize = 10;
}
