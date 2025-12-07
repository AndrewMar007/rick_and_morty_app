import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String text;
  final Size size;
  final Function() onTap;
  const CardWidget({super.key, required this.size, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        child: Container(
          height: size.height * 0.2,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              color: const Color.fromARGB(255, 46, 47, 53)),
          child: Row(
            children: [
              Container(
                  child: Placeholder(),
                  height: size.height * 0.2,
                  width: size.width * 0.4),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      "status - Alive",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
