import 'package:equatable/equatable.dart';
import 'package:rick_and_morty_app/model/location_model.dart';

class CharacterModel extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final LocationModel location;
  final List<String> episode;
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
        location: LocationModel.fromJson(json["location"]),
        episode: List<String>.from(json["episode"]),
        url: json["url"],
        created: json["created"]);
  }

  @override
  List<Object?> get props =>
      [id, name, status, species, type, gender, image, episode, url, created];

}
