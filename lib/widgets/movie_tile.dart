import 'package:flutter/material.dart';
import '../model/movies.dart';
import 'fast_image.dart';

class MovieTile extends StatelessWidget {
  final MovieResults movieItem;
  final VoidCallback? onPressed;

  const MovieTile({required this.movieItem, required this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Container(
                  width: double.infinity,
                  color: Colors.blue,
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: FastImage(imageUrl: movieItem.backdropPath ?? ""),
                  )),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  movieItem.title ?? "Title not found",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
