import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/view/bloc/character_bloc/character_bloc_event.dart';
import 'package:rick_and_morty_app/view/bloc/character_bloc/character_bloc_state.dart';
import 'package:rick_and_morty_app/view/pages/character_information_page.dart';
import 'package:rick_and_morty_app/view/widgets/custom_text_field.dart';

import '../bloc/character_bloc/character_bloc.dart';
import '../widgets/card_widget.dart';

class SearchCharacterPage extends StatefulWidget {
  const SearchCharacterPage({super.key});

  @override
  State<SearchCharacterPage> createState() => _SearchCharacterPageState();
}

class _SearchCharacterPageState extends State<SearchCharacterPage> {
  final TextEditingController _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 2.0,
        shadowColor: Colors.black,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Search",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(253, 19, 19, 19),
        automaticallyImplyLeading: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Container(
        color: const Color.fromARGB(255, 30, 32, 38),
        height: size.height,
        width: size.width,
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            CustomTextField(
                height: size.height * 0.06,
                width: size.width * 0.9,
                hintText: "Tap to find character",
                controller: _textController,
                onSubmitted: (value) {
                  if (value.isEmpty) {
                    context
                        .read<CharacterBlocFindByName>()
                        .add(ResetBlocEvent());
                    return;
                  } else {
                    BlocProvider.of<CharacterBlocFindByName>(context)
                        .add(GetCharacterByNameEvent(name: value));
                  }
                }),
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
              height: size.height * 0.78,
              child: BlocBuilder<CharacterBlocFindByName, CharacterBlocState>(
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
                } else if (state is FetchCharacterByNameLoadedState) {
                  return ListView.builder(
                    itemCount: state.charactersList.length,
                    itemBuilder: (context, index) {
                      final item = state.charactersList[index];
                      return CardWidget(
                        size: size,
                        text: item.name,
                        imageUrl: item.image,
                        species: item.species,
                        status: item.status,
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                CharacterInformationPage(model: item),
                          ),
                        ),
                      );
                    },
                  );
                } else if (state is ErrorState) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          state.failure.message,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Color.fromARGB(255, 124, 220, 255)),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        TextButton(
                          child: Container(
                              height: size.height * 0.05,
                              width: size.width * 0.4,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 125, 220, 255))),
                              child: const Center(
                                  child: Text(
                                "Tap to get data",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 122, 220, 255)),
                              ))),
                          onPressed: () {
                            BlocProvider.of<CharacterBlocFindByName>(context)
                                .add(GetCharacterByNameEvent(
                                    name: _textController.text));
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: Text(
                      "Search your favorite character",
                      style:
                          TextStyle(color: Color.fromARGB(255, 110, 194, 225)),
                    ),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
