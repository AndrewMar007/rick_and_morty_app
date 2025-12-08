import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/model/episode_model.dart';
import 'package:rick_and_morty_app/view/bloc/character_bloc/character_bloc.dart';
import 'package:rick_and_morty_app/view/bloc/character_bloc/character_bloc_event.dart';
import 'package:rick_and_morty_app/view/bloc/character_bloc/character_bloc_state.dart';

import '../model/character_model.dart';

class EpisodeInformationPage extends StatefulWidget {
  final EpisodeModel model;
  const EpisodeInformationPage({super.key, required this.model});

  @override
  State<EpisodeInformationPage> createState() => _EpisodeInformationPageState();
}

class _EpisodeInformationPageState extends State<EpisodeInformationPage> {
  @override
  void initState() {
    super.initState();
    _loadData();
  }

  _loadData() {
    final map = widget.model.characters
        .map((e) => int.parse(Uri.parse(e).pathSegments.last))
        .toList();
    BlocProvider.of<CharacterBlocFindById>(context)
        .add(FindCharacterByIdEvent(id: map));
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
          "Episode info",
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
                  child: FittedBox(
                    child: Text(
                        widget.model.name.isEmpty
                            ? "No info"
                            : widget.model.name,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ),
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
                        SizedBox(
                          width: size.width * 0.015,
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
                    Row(
                      children: [
                        const Text("Air date:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Text(
                            widget.model.airDate.isEmpty
                                ? "No info"
                                : widget.model.airDate,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                      ],
                    ),
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Row(
                      children: [
                        const Text("Code of the episode:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold)),
                        SizedBox(
                          width: size.width * 0.02,
                        ),
                        Text(
                            widget.model.episode.isEmpty
                                ? "No info"
                                : widget.model.episode,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 16)),
                      ],
                    ),

                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    // Text(
                    //     "Type - ${widget.model.type.isEmpty ? "No info" : widget.model.type}",
                    //     style: TextStyle(color: Colors.white, fontSize: 16)),
                    // SizedBox(
                    //   height: size.height * 0.03,
                    // ),
                    const Text(
                      "Characters:",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 19),
                    ),
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      height: size.height * 0.58,
                      child: BlocBuilder<CharacterBlocFindById,
                          CharacterBlocState>(builder: (context, state) {
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
                        } else if (state is FindCharacterByIdLoadedState) {
                          return ListView.builder(
                              itemCount: state.model.length,
                              itemBuilder: (context, index) {
                                final List<CharacterModel> list = state.model;
                                //final List<EpisodeModel> list = model.episode.map((e) => EpisodeModel.fromJson(e)).toList();
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      vertical: size.height * 0.01),
                                  child: Row(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.0)),
                                          height: size.height * 0.09,
                                          width: size.width * 0.19,
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image.network(
                                                list[index].image,
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent?
                                                            loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  color: const Color.fromARGB(
                                                      255, 110, 194, 225),
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          loadingProgress
                                                              .expectedTotalBytes!
                                                      : null,
                                                ),
                                              );
                                            }),
                                          )),
                                      SizedBox(
                                        width: size.width * 0.05,
                                      ),
                                      SizedBox(
                                        height: size.height * 0.08,
                                        width: size.width * 0.65,
                                        child: Center(
                                          child: Text(
                                            list[index].name,
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            maxLines: 2,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
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
