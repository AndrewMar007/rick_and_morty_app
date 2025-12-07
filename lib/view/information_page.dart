import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InformationPage extends StatelessWidget {
  final String text;
  const InformationPage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 4.0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Padding(
          padding: EdgeInsets.only(left: size.width * 0.135),
          child: Text(
            "Rick and Morty App",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        backgroundColor: Color.fromARGB(253, 19, 19, 19),
        automaticallyImplyLeading: true,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white, // Match AppBar's background color
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromARGB(255, 30, 32, 38),
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
                    child: Container(
                      height: size.height * 0.3,
                      width: size.width * 0.6,
                      child: Placeholder(),
                      
                    )),
                     SizedBox(
                          height: size.height * 0.02,
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text("$text",
                              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Align(alignment: Alignment.center ,child: Text("Status - ", style: TextStyle(color: Colors.white))),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    
                      SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text("Gender - ", style: TextStyle(color: Colors.white)),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text("Origin - ", style: TextStyle(color: Colors.white)),
                      SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text("Species - ", style: TextStyle(color: Colors.white)),
                      SizedBox(
                          height: size.height * 0.03,
                        ),
                        Text("Type - ", style: TextStyle(color: Colors.white)),
    
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
