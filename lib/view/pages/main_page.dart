import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/view/bloc/character_bloc/character_bloc.dart';
import 'package:rick_and_morty_app/view/bloc/character_bloc/character_bloc_event.dart';
import 'package:rick_and_morty_app/view/bloc/character_bloc/character_bloc_state.dart';
import 'package:rick_and_morty_app/view/pages/character_information_page.dart';
import 'package:rick_and_morty_app/view/pages/search_character_page.dart';
import 'package:rick_and_morty_app/view/widgets/card_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    context.read<CharacterBlocList>().add(GetCharacterListEvent());

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final position = _scrollController.position;

    if (position.pixels >= position.maxScrollExtent - 200) {
      context.read<CharacterBlocList>().add(GetCharacterListEvent());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SearchCharacterPage()));
              },
              icon: const Icon(
                Icons.search,
                color: Colors.white,
                size: 26.0,
              )),
        ],
        elevation: 4.0,
        title: const Text(
          "Rick and Morty App",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(253, 19, 19, 19),
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: const Color.fromARGB(255, 30, 32, 38),
        child: BlocBuilder<CharacterBlocList, CharacterBlocState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return Center(
                child: SizedBox(
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
                  ),
              );
            }
            if (state is ErrorState &&
                state is! FetchListOfCharactersLoadedState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                     Text(
                      state.failure.message,
                      textAlign: TextAlign.center,
                      style:
                          const TextStyle(color: Color.fromARGB(255, 124, 220, 255)),
                    ),
                    SizedBox(height: size.height * 0.02,),
                    TextButton(
                      child: Container(
                        height: size.height * 0.05,
                        width: size.width * 0.4,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              border: Border.all(
                                  color: const Color.fromARGB(255, 125, 220, 255))),
                          child: const Center(child: Text("Tap to get data", style: TextStyle(color: Color.fromARGB(255, 122, 220, 255)),))),
                      onPressed: () {
                        context
                            .read<CharacterBlocList>()
                            .add(GetCharacterListEvent());
                      },
                    ),
                  ],
                ),
              );
            }

            if (state is FetchListOfCharactersLoadedState) {
              final list = state.characterModelList;

              return ListView.builder(
                controller: _scrollController,
                itemCount: list.length + (state.hasMore ? 1 : 0),
                itemBuilder: (context, index) {
                  if (index == list.length) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 110, 194, 225),
                        ),
                      ),
                    );
                  }

                  final item = list[index];

                  return CardWidget(
                    size: size,
                    text: item.name.isEmpty ? "No info" : item.name,
                    imageUrl: item.image,
                    species: item.species.isEmpty ? "No info" : item.species,
                    status: item.status.isEmpty ? "No info" : item.status,
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CharacterInformationPage(model: item),
                      ),
                    ),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
