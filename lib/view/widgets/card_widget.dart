import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final String text;
  final String imageUrl;
  final String status;
  final Size size;
  final String species;
  final Function() onTap;
  const CardWidget(
      {super.key,
      required this.size,
      required this.text,
      required this.onTap,
      required this.species,
      required this.imageUrl,
      required this.status});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        child: Container(
          height: size.height * 0.19,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromARGB(255, 46, 47, 53)),
          child: Row(
            children: [
              SizedBox(
                  height: size.height * 0.2,
                  width: size.width * 0.4,
                  child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          bottomLeft: Radius.circular(10.0)),
                      child: imageUrl.isNotEmpty
                          ? Image.network(imageUrl, loadingBuilder:
                              (BuildContext context, Widget child,
                                  ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(
                                child: CircularProgressIndicator(
                                  color:
                                      const Color.fromARGB(255, 110, 194, 225),
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            })
                          : const Icon(
                              Icons.image_not_supported_outlined,
                              color: Colors.white,
                              size: 30.0,
                            ))),
              Padding(
                padding: EdgeInsets.only(left: size.width * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height * 0.02,
                    ),
                    SizedBox(
                      width: size.width * 0.48,
                      child: Text(
                        text,
                        softWrap: true,
                        maxLines: 2,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.circle,
                          size: 14,
                          color: status == "Alive"
                              ? Colors.green
                              : status == "Dead"
                                  ? Colors.red
                                  : status == "unknown"
                                      ? Colors.grey
                                      : Colors.transparent,
                        ),
                        SizedBox(
                          width: size.width * 0.015,
                        ),
                        SizedBox(
                          width: size.width * 0.4,
                          child: Text(
                            "$status - $species",
                            softWrap: true,
                            maxLines: 2,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    )
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
