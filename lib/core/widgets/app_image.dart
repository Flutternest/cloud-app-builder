import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_network/image_network.dart';

class AppImage extends StatelessWidget {
  const AppImage(this.imageUrl,
      {super.key, required this.width, required this.height});

  final String imageUrl;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return kIsWeb
        ? ImageNetwork(
            image: imageUrl,
            height: height,
            width: width,
          )
        : Image.network(
            imageUrl,
            width: width,
            height: height,
          );
  }
}
