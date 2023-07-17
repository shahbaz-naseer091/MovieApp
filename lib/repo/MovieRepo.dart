import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:learn_movie_app/model/movie_detail.dart';
import 'package:learn_movie_app/model/movie_videos.dart';

import '../model/movies.dart';

class MovieRepo {
  static const _authKey =
      "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxMzc3NDMxZTkwYzk5YjRkZWE5ZGE3ZWU2ZTBhN2UyMiIsInN1YiI6IjY0OTI4YTgxYzI4MjNhMDBmZmEwNmJjOCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Hcjit9v6Ith9GAdozGIzSmQ9Pjz6qEcpsOoVIfz4X_E";
  static const _apiKey = "?api_key=1377431e90c99b4dea9da7ee6e0a7e22";
  static const _baseUrl = "https://api.themoviedb.org/3/movie/";

  static final _client = http.Client();

  final Map<String, String> _requestHeaders = {
    'Content-Type': 'application/json',
    'Authorization': _authKey,
    'API-Key': _apiKey,
  };

  Future<void> fetchUpcomingMovies(
      void Function(List<MovieResults>?, String) callback) async {
    try {
      var url = Uri.parse("${_baseUrl}upcoming$_apiKey");

      Response response = await _client.get(url, headers: _requestHeaders);
      print("$url\n${response.statusCode}");

      if (response.statusCode == 200) {
        var data = response.body;
        Movie dataModel = Movie.fromJson(jsonDecode(data));
        return callback(dataModel.results!, "");
      } else {
        return callback([], "");
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<void> fetchMovieDetails(
      int movieID, void Function(MovieDetail?, String) callback) async {
    try {
      var url = Uri.parse("$_baseUrl$movieID");
      Response response = await _client.get(url, headers: _requestHeaders);
      print("$url\n${response.statusCode}");

      if (response.statusCode == 200) {
        var data = response.body;
        MovieDetail detail = MovieDetail.fromJson(jsonDecode(data));
        print(detail.toString());
        return callback(detail, "");
      } else {
        return callback(null, "");
      }
    } catch (ex) {
      rethrow;
    }
  }

  Future<void> fetchTrailer(
      int movieID, void Function(MovieVideos?, String) callback) async {
    try {
      var url = Uri.parse("$_baseUrl$movieID/videos$_apiKey");
      Response response = await _client.get(url, headers: _requestHeaders);
      print("$url\n${response.statusCode}");

      if (response.statusCode == 200) {
        var data = response.body;
        MovieVideos videos = MovieVideos.fromJson(jsonDecode(data));
        return callback(videos, "");
      } else {
        return callback(null, "");
      }
    } catch (ex) {
      rethrow;
    }
  }
}
