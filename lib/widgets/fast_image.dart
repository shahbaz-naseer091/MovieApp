import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class FastImage extends StatelessWidget {
  final int width = 40;
  final int heigt = 40;
  final String imageUrl;

  const FastImage({required this.imageUrl, width, height, super.key});

  @override
  Widget build(BuildContext context) {
    String url;

    if (imageUrl.contains("http") || imageUrl.contains("https")) {
      url = imageUrl;
    } else {
      url = "https://image.tmdb.org/t/p/original/$imageUrl";
    }

    return CachedNetworkImage(
      imageUrl: url,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      placeholder: (context, url) => const Center(
        child: SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
