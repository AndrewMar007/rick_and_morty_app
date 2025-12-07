import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty_app/view/information_page.dart';
import 'package:rick_and_morty_app/view/widgets/card_widget.dart';

List<String> list = ["rick", "morty", "alien", "death", "nikola"];

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        title: Align(
            alignment: Alignment.center,
            child: Text(
              "Rick and Morty App",
              style: TextStyle(color: Colors.white, fontSize: 16),
            )),
        backgroundColor: Color.fromARGB(253, 19, 19, 19),
        automaticallyImplyLeading: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white, // Match AppBar's background color
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Container(
        height: size.height,
        width: size.width,
        color: Color.fromARGB(255, 30, 32, 38),
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, int index) {
            return CardWidget(
              size: size,
              text: list[index],
              onTap: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => InformationPage(text: list[index]))),
            );
          },
        ),
      ),
    );
  }
}
