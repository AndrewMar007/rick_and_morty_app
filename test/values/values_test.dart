import 'package:rick_and_morty_app/model/character_model.dart';
import 'package:rick_and_morty_app/model/episode_model.dart';
import 'package:rick_and_morty_app/model/location_model.dart';

class CharacterModelValues {
  static const List<CharacterModel> listOfCharacters = [rick, morty];
  static const List<int> idList = [1, 2, 3];
  static const LocationModel location = LocationModel(
    name: "Citadel of Ricks",
    url: "https://rickandmortyapi.com/api/location/3",
  );
  static const CharacterModel rick = CharacterModel(
    id: 1,
    name: "Rick Sanchez",
    status: "Alive",
    species: "Human",
    type: "",
    gender: "Male",
    image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
    location: location,
    episode: [
      "https://rickandmortyapi.com/api/episode/1",
      "https://rickandmortyapi.com/api/episode/2",
      "https://rickandmortyapi.com/api/episode/3",
      "https://rickandmortyapi.com/api/episode/4",
      "https://rickandmortyapi.com/api/episode/5",
      "https://rickandmortyapi.com/api/episode/6",
      "https://rickandmortyapi.com/api/episode/7",
      "https://rickandmortyapi.com/api/episode/8",
      "https://rickandmortyapi.com/api/episode/9",
      "https://rickandmortyapi.com/api/episode/10"
    ],
    url: "https://rickandmortyapi.com/api/character/1",
    created: "2017-11-04T18:48:46.250Z",
  );

  static const CharacterModel morty = CharacterModel(
    id: 2,
    name: "Morty Smith",
    status: "Alive",
    species: "Human",
    type: "",
    gender: "Male",
    image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
    location: location,
    episode: [
      "https://rickandmortyapi.com/api/episode/1",
      "https://rickandmortyapi.com/api/episode/2",
      "https://rickandmortyapi.com/api/episode/3",
      "https://rickandmortyapi.com/api/episode/4",
      "https://rickandmortyapi.com/api/episode/5",
      "https://rickandmortyapi.com/api/episode/6",
      "https://rickandmortyapi.com/api/episode/7",
      "https://rickandmortyapi.com/api/episode/8",
      "https://rickandmortyapi.com/api/episode/9",
      "https://rickandmortyapi.com/api/episode/10",
    ],
    url: "https://rickandmortyapi.com/api/character/2",
    created: "2017-11-04T18:50:21.651Z",
  );

  static const CharacterModel character = CharacterModel(
    id: 1,
    name: "Rick Sanchez",
    status: "Alive",
    species: "Human",
    type: "",
    gender: "Male",
    image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
    location: location,
    episode: [
      "https://rickandmortyapi.com/api/episode/1",
      "https://rickandmortyapi.com/api/episode/2",
    ],
    url: "https://rickandmortyapi.com/api/character/1",
    created: "2017-11-04T18:48:46.250Z",
  );

  static const CharacterModel characterMorty = CharacterModel(
    id: 2,
    name: "Morty Smith",
    status: "Alive",
    species: "Human",
    type: "",
    gender: "Male",
    image: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
    location: location,
    episode: [
      "https://rickandmortyapi.com/api/episode/1",
      "https://rickandmortyapi.com/api/episode/2",
    ],
    url: "https://rickandmortyapi.com/api/character/2",
    created: "2017-11-04T18:50:21.651Z",
  );
}

class EpisodeModelValues {
  static const List<EpisodeModel> episodes = [
    EpisodeModel(
      id: 1,
      name: "Pilot",
      airDate: "December 2, 2013",
      episode: "S01E01",
      characters: [
        "https://rickandmortyapi.com/api/character/1",
        "https://rickandmortyapi.com/api/character/2",
        "https://rickandmortyapi.com/api/character/35",
        "https://rickandmortyapi.com/api/character/38",
        "https://rickandmortyapi.com/api/character/62",
        "https://rickandmortyapi.com/api/character/92",
        "https://rickandmortyapi.com/api/character/127",
        "https://rickandmortyapi.com/api/character/144",
        "https://rickandmortyapi.com/api/character/158",
        "https://rickandmortyapi.com/api/character/175",
        "https://rickandmortyapi.com/api/character/179",
        "https://rickandmortyapi.com/api/character/181",
        "https://rickandmortyapi.com/api/character/239",
        "https://rickandmortyapi.com/api/character/249",
        "https://rickandmortyapi.com/api/character/271",
        "https://rickandmortyapi.com/api/character/338",
        "https://rickandmortyapi.com/api/character/394",
        "https://rickandmortyapi.com/api/character/395",
        "https://rickandmortyapi.com/api/character/435",
      ],
      url: "https://rickandmortyapi.com/api/episode/1",
      created: "2017-11-10T12:56:33.798Z",
    ),
    EpisodeModel(
      id: 2,
      name: "Lawnmower Dog",
      airDate: "December 9, 2013",
      episode: "S01E02",
      characters: [
        "https://rickandmortyapi.com/api/character/1",
        "https://rickandmortyapi.com/api/character/2",
        "https://rickandmortyapi.com/api/character/38",
        "https://rickandmortyapi.com/api/character/46",
        "https://rickandmortyapi.com/api/character/63",
        "https://rickandmortyapi.com/api/character/80",
        "https://rickandmortyapi.com/api/character/175",
        "https://rickandmortyapi.com/api/character/221",
        "https://rickandmortyapi.com/api/character/239",
        "https://rickandmortyapi.com/api/character/246",
        "https://rickandmortyapi.com/api/character/304",
        "https://rickandmortyapi.com/api/character/305",
        "https://rickandmortyapi.com/api/character/306",
        "https://rickandmortyapi.com/api/character/329",
        "https://rickandmortyapi.com/api/character/338",
        "https://rickandmortyapi.com/api/character/396",
        "https://rickandmortyapi.com/api/character/397",
        "https://rickandmortyapi.com/api/character/398",
        "https://rickandmortyapi.com/api/character/405",
      ],
      url: "https://rickandmortyapi.com/api/episode/2",
      created: "2017-11-10T12:56:33.916Z",
    ),
  ];
  static const EpisodeModel episode = EpisodeModel(
    id: 1,
    name: "Pilot",
    airDate: "December 2, 2013",
    episode: "S01E01",
    characters: [
      "https://rickandmortyapi.com/api/character/1",
      "https://rickandmortyapi.com/api/character/2",
      "https://rickandmortyapi.com/api/character/35",
      "https://rickandmortyapi.com/api/character/38",
      "https://rickandmortyapi.com/api/character/62",
      "https://rickandmortyapi.com/api/character/92",
      "https://rickandmortyapi.com/api/character/127",
      "https://rickandmortyapi.com/api/character/144",
      "https://rickandmortyapi.com/api/character/158",
      "https://rickandmortyapi.com/api/character/175",
      "https://rickandmortyapi.com/api/character/179",
      "https://rickandmortyapi.com/api/character/181",
      "https://rickandmortyapi.com/api/character/239",
      "https://rickandmortyapi.com/api/character/249",
      "https://rickandmortyapi.com/api/character/271",
      "https://rickandmortyapi.com/api/character/338",
      "https://rickandmortyapi.com/api/character/394",
      "https://rickandmortyapi.com/api/character/395",
      "https://rickandmortyapi.com/api/character/435",
    ],
    url: "https://rickandmortyapi.com/api/episode/1",
    created: "2017-11-10T12:56:33.798Z",
  );
}
