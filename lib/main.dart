import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_app/view/bloc/character_bloc/character_bloc.dart';
import 'package:rick_and_morty_app/view/bloc/episode_bloc/episodes_bloc.dart';
import 'package:rick_and_morty_app/view/main_page.dart';
import 'injection_container.dart' as di;

void main() async {
  await di.init();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<CharacterBlocList>(
        create: (context) => CharacterBlocList(characterViewModel: di.sl())),
    BlocProvider<CharacterBlocFindByName>(
        create: (context) =>
            CharacterBlocFindByName(characterViewModel: di.sl())),
    BlocProvider<EpisodesBloc>(
        create: (context) => EpisodesBloc(episodeViewModel: di.sl())),
    BlocProvider<CharacterBlocFindById>(
        create: (context) =>
            CharacterBlocFindById(characterViewModel: di.sl())),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        //colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
