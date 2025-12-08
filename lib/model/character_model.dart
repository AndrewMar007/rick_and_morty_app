import 'package:equatable/equatable.dart';

class CharacterModel extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final Map<String, dynamic> location;
  final List<dynamic> episode;
  final String url;
  final String created;
  const CharacterModel(
      {required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.type,
      required this.gender,
      required this.image,
      required this.location,
      required this.episode,
      required this.url,
      required this.created});

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
        id: json["id"],
        name: json["name"],
        status: json["status"],
        species: json["species"],
        type: json["type"],
        gender: json["gender"],
        image: json["image"],
        location: json["location"],
        episode: json["episode"],
        url: json["url"],
        created: json["created"]);
  }

  @override
  List<Object?> get props =>
      [id, name, status, species, type, gender, image, episode, url, created];

}
