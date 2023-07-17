// ignore: file_names
import 'package:flutter/material.dart';
import 'package:learn_movie_app/model/movie_detail.dart';
import 'package:learn_movie_app/screens/movie_hall_selection.dart';
import 'package:learn_movie_app/utils/extensions.dart';
import 'package:learn_movie_app/widgets/fast_image.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../repo/MovieRepo.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  MovieDetail? movieDetail;

  Details({required this.movieDetail, super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final MovieRepo _movieRepo = MovieRepo();

  bool isVideoPlaying = false;

  String videoUrl = "";

  @override
  Widget build(BuildContext context) {
    String posterPath =
        "https://image.tmdb.org/t/p/original${widget.movieDetail!.posterPath}";

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: !isVideoPlaying
            ? defaultWidget(posterPath, context)
            : playVideo(videoUrl),
      ),
    );
  }

  Widget defaultWidget(String posterPath, BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        child: Container(
          color: Colors.orange,
          alignment: Alignment.center,
          child: Stack(
            children: [
              FastImage(
                imageUrl: posterPath,
              ),
              header(context),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 80, 0, 0),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.movieDetail!.originalTitle ?? "Unknown",
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "In Theaters ${widget.movieDetail!.releaseDate?.toCustomDateFormat()}",
                      style: const TextStyle(color: Colors.white, fontSize: 22),
                    ),
                    const SizedBox(height: 5),
                    ticketsButton(context, widget.movieDetail!),
                    const SizedBox(height: 5),
                    trailerButton(context, widget.movieDetail!)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      Expanded(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Genres",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                  height: 30,
                  child: genreList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 0.5,
                  color: Colors.black,
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Overview",
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.movieDetail?.overview ?? "",
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                    )
                  ],
                ))
              ],
            ),
          ),
        ),
      )
    ]);
  }

  ListView genreList() {
    Color? genreBgColor = Colors.white;

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.movieDetail!.genres?.length,
      itemBuilder: (context, index) {
        genreBgColor =
            getGenreBgColor(widget.movieDetail?.genres![index].name ?? "");
        return Container(
          height: 28,
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              color: genreBgColor, borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
            child: Text(
              widget.movieDetail?.genres?[index].name ?? "Unknown",
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  SizedBox ticketsButton(BuildContext context, MovieDetail movieDetail) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
          onPressed: () {
            //pass movie title & release date
            context.pushToNextScreen(MovieHall(
                movieName: movieDetail.originalTitle,
                releaseDate: movieDetail.releaseDate?.toCustomDateFormat()));
          },
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Get Tickets",
              style: TextStyle(fontSize: 16),
            ),
          )),
    );
  }

  SizedBox trailerButton(BuildContext context, MovieDetail movieDetail) {
    return SizedBox(
      width: 200,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              side: const BorderSide(color: Colors.blue, width: 2),
              backgroundColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8))),
          onPressed: () {
            _movieRepo.fetchTrailer(movieDetail.id!, (video, message) {
              if (video!.results != null) {
                // playVideo(video.results![0].key);

                setState(() {
                  videoUrl = video.results![0].key;
                  isVideoPlaying = true;
                });
              }
            });
          },
          child: const Padding(
            padding: EdgeInsets.all(10),
            child: Row(children: [
              Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
              Text(
                "Watch Trailer",
                style: TextStyle(fontSize: 16),
              )
            ]),
          )),
    );
  }

  Container header(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              context.popWidget();
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Text("Watch",
                  style: TextStyle(color: Colors.white, fontSize: 22)))
        ],
      ),
    );
  }

  Color? getGenreBgColor(String genre) {
    switch (genre) {
      case "Science Fiction":
        return Colors.purple;

      case "Action":
        return Colors.red;

      case "Adventure":
        return Colors.orange;

      case "Comedy":
        return Colors.amber;

      case "Family":
        return Colors.green;

      case "Romantic":
        return Colors.lightBlueAccent;

      case "Horror":
        return Colors.green[900];

      case "Thriller":
        return Colors.indigo;

      case "Fantasy":
        return Colors.pink;
    }

    return Colors.blue;
  }

  Widget playVideo(String key) {
    return Stack(
      fit: StackFit.expand,
      children: [
        YoutubePlayer(
          controller: YoutubePlayerController(
            initialVideoId: YoutubePlayer.convertUrlToId(key).toString(),
            flags: const YoutubePlayerFlags(
              autoPlay: true,
              mute: false,
            ),
          ),
          showVideoProgressIndicator: true,
        )
      ],
    );
  }
}
