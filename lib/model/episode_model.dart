class EpisodeModel {
  int id;
  String name;
  String airDate;
  String episode;
  List<dynamic> characters;
  String url;
  String created;

  EpisodeModel(
      {required this.id,
      required this.name,
      required this.airDate,
      required this.episode,
      required this.characters,
      required this.url,
      required this.created});
  factory EpisodeModel.fromJson(Map<String, dynamic> json) {
    return EpisodeModel(
        id: json["id"],
        name: json["name"],
        airDate: json["air_date"],
        episode: json["episode"],
        characters: json["characters"],
        url: json["url"],
        created: json["created"]);
  }
}
