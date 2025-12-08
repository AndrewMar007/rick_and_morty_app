import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/model/episode_model.dart';
import 'package:rick_and_morty_app/view/bloc/episode_bloc/episodes_bloc.dart';
import 'package:rick_and_morty_app/view/bloc/episode_bloc/episodes_bloc_event.dart';
import 'package:rick_and_morty_app/view/pages/episode_infromation_page.dart';

import '../../model/character_model.dart';
import '../bloc/episode_bloc/episodes_bloc_state.dart';

class CharacterInformationPage extends StatefulWidget {
  final CharacterModel model;
  const CharacterInformationPage({super.key, required this.model});

  @override
  State<CharacterInformationPage> createState() => _CharacterInformationPageState();
}

class _CharacterInformationPageState extends State<CharacterInformationPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() {
    List<dynamic> list = [];
    list.addAll(widget.model.episode);
    final map =
        list.map((e) => int.parse(Uri.parse(e).pathSegments.last)).toList();
    BlocProvider.of<EpisodesBloc>(context)
        .add(FetchListOfEpisodes(episodes: map));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        elevation: 4.0,
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: const Text(
          "Character info",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
        backgroundColor: const Color.fromARGB(253, 19, 19, 19),
        automaticallyImplyLeading: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: const Color.fromARGB(255, 30, 32, 38),
          height: size.height,
          width: size.width,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.05,
                ),
                Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      height: size.height * 0.2,
                      width: size.width * 0.4,
                      child: SizedBox(
                          height: size.height * 0.2,
                          width: size.width * 0.4,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(30.0),
                              child: Image(
                                  image: NetworkImage(widget.model.image)))),
                    )),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                      widget.model.name.isEmpty ? "No info" : widget.model.name,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    alignment: Alignment.center,
                    width: size.width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 16,
                          color: widget.model.status == "Alive"
                              ? Colors.green
                              : widget.model.status == "Dead"
                                  ? Colors.red
                                  : widget.model.status == "unknown"
                                      ? Colors.grey
                                      : Colors.transparent,
                        ),
                        SizedBox(
                          width: size.width * 0.015,
                        ),
                        FittedBox(
                          child: Text(
                            "${widget.model.status.isEmpty ? "No info" : widget.model.status} - ${widget.model.species.isEmpty ? "No info" : widget.model.species}",
                            softWrap: true,
                            maxLines: 2,
                            style: const TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.02,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        "Gender - ${widget.model.gender.isEmpty ? "No info" : widget.model.gender}",
                        style: const TextStyle(color: Colors.white, fontSize: 16)),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                        "Location - ${widget.model.location.isEmpty ? "No info" : widget.model.location["name"]}",
                        style: const TextStyle(color: Colors.white, fontSize: 16)),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                        "Species - ${widget.model.species.isEmpty ? "No info" : widget.model.species}",
                        style: const TextStyle(color: Colors.white, fontSize: 16)),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                        "Type - ${widget.model.type.isEmpty ? "No info" : widget.model.type}",
                        style: const TextStyle(color: Colors.white, fontSize: 16)),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    const Text(
                      "Episodes:",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      height: size.height * 0.2,
                      child: BlocBuilder<EpisodesBloc, EpisodesBlocState>(
                          builder: (context, state) {
                        if (state is LoadingState) {
                          return SizedBox(
                            height: size.height * 0.6,
                            width: size.width,
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: size.height * 0.06,
                                    width: size.width * 0.13,
                                    child: const CircularProgressIndicator(
                                      color: Color.fromARGB(255, 110, 194, 225),
                                    ),
                                  ),
                                  SizedBox(
                                    height: size.height * 0.03,
                                  ),
                                  const Text(
                                    "Receiving data in progress ...",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 110, 194, 225),
                                      fontSize: 13.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        } else if (state is EpisodesLoadedState) {
                          return ListView.builder(
                              itemCount: state.episodes.length,
                              itemBuilder: (context, index) {
                                final List<EpisodeModel> list = state.episodes;
                                //final List<EpisodeModel> list = model.episode.map((e) => EpisodeModel.fromJson(e)).toList();
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                EpisodeInformationPage(
                                                    model: list[index])));
                                  },
                                  child: SizedBox(
                                    height: size.height * 0.06,
                                    child: Text(
                                      "Episode - ${list[index].id} - ${list[index].name}",
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                );
                              });
                        } else if (state is ErrorState) {
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "No internet connection\nTurn on please",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 124, 220, 255)),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                TextButton(
                                  child: Container(
                                      height: size.height * 0.05,
                                      width: size.width * 0.4,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          border: Border.all(
                                              color: const Color.fromARGB(
                                                  255, 125, 220, 255))),
                                      child: const Center(
                                          child: Text(
                                        "Tap to get data",
                                        style: TextStyle(
                                            color: Color.fromARGB(
                                                255, 122, 220, 255)),
                                      ))),
                                  onPressed: () {
                                    _loadData();
                                  },
                                ),
                              ],
                            ),
                          );
                        } else {
                          return const Text("List of episodes");
                        }
                      }),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
