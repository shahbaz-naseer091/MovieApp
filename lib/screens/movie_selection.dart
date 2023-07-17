import 'package:flutter/material.dart';
import 'package:learn_movie_app/repo/MovieRepo.dart';
import 'package:learn_movie_app/screens/details.dart';
import 'package:learn_movie_app/utils/extensions.dart';
import 'package:searchbar_animation/searchbar_animation.dart';
import '../model/movies.dart';
import '../widgets/movie_tile.dart';
import '../widgets/my_progress_indicator.dart';

class MovieSelection extends StatefulWidget {
  MovieSelection({Key? key}) : super(key: key);

  @override
  State<MovieSelection> createState() => _MovieSelectionState();
}

class _MovieSelectionState extends State<MovieSelection> {
  MovieRepo _movieRepo = MovieRepo();

  TextEditingController textController = TextEditingController();

  List<MovieResults>? moviesList = [];
  List<MovieResults>? searchList = [];
  List<MovieResults>? dataList = [];

  bool _loading = false;
  bool _onSearch = false;

  Future<void> _fetchMovieImages() async {
    setState(() {
      _loading = true;
    });

    _movieRepo.fetchUpcomingMovies((list, messasge) {
      if (moviesList != null) {
        setState(() {
          moviesList = list;
          dataList = list;
        });
      } else {
        context.showSnackBar(messasge);
      }

      setState(() {
        _loading = false;
      });
    });
  }

  Future<void> _fetchMovieDetails(int movieID) async {
    setState(() {
      _loading = true;
    });

    _movieRepo.fetchMovieDetails(movieID, (detail, message) {
      if (detail != null) {
        context.pushToNextScreen(Details(
          movieDetail: detail,
        ));
      } else {
        context.showSnackBar(message);
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchMovieImages();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white38,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  (!_onSearch) ? getHeader() : Container(),
                  Expanded(
                    child: getSearchView(),
                  )
                ],
              ),
            ),
            Visibility(visible: _loading, child: const MyProgressIndicator()),
            Expanded(
              child: Container(color: Colors.grey[200], child: setMoviesList()),
            ),
          ],
        ),
      ),
    );
  }

  ListView setMoviesList() {
    return ListView.builder(
        itemCount: dataList!.length,
        itemBuilder: (context, index) {
          return MovieTile(
            movieItem: dataList![index],
            onPressed: () {
              _fetchMovieDetails(dataList![index].id!);
            },
          );
        });
  }

  Widget getSearchView() {
    return SearchBarAnimation(
        hintText: "TV Shows, Movies & many more",
        isOriginalAnimation: false,
        onFieldSubmitted: () {},
        durationInMilliSeconds: 500,
        isSearchBoxOnRightSide: true,
        textEditingController: textController,
        onPressButton: (isCheck) {
          setState(() {
            _onSearch = true;
          });
        },
        onCollapseComplete: () {
          setState(() {
            dataList = moviesList;
            _onSearch = false;
            textController.clear();
          });
        },
        onEditingComplete: () {},
        onChanged: (value) {
          setState(() {
            dataList = moviesList!
                .where((f) => f.title!
                    .toString()
                    .toLowerCase()
                    .contains(value.toString().toLowerCase()))
                .toList();
          });
        },
        trailingWidget: const Icon(
          Icons.search,
          size: 20,
          color: Colors.black,
        ),
        secondaryButtonWidget: const Icon(
          Icons.close,
          size: 20,
          color: Colors.black,
        ),
        buttonWidget: const Icon(
          Icons.search,
          size: 20,
          color: Colors.black,
        ));
  }

  Widget getHeader() {
    return const Padding(
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child:
            Text("Watch", style: TextStyle(color: Colors.black, fontSize: 22)));
  }
}
