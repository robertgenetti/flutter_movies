import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

import 'movie_model.dart';

class HttpHelper {
  static const String urlKey = 'api_key=edf4e8ccaa47bc2576e026f78cf4f51a';
  static const String urlBase = 'https://api.themoviedb.org/3';
  static const String urlUpcoming = '/movie/upcoming?';
  static const String urlSearch = '/search/movie?';
  static const String urlLanguage = '&language=en-US';
  static const String defaultImage = 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';
  static const String iconBase = 'https://image.tmdb.org/t/p/w92/';

  Future getUpcoming() async {
    final String upcoming = urlBase + urlUpcoming + urlKey
        + urlLanguage;
    http.Response res = await http.get(upcoming);
    if (res.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(res.body);
      final moviesDynamic = jsonResponse['results'];
      List movies = moviesDynamic.map((i) =>
          Movie.fromJson(i)).toList();
      return movies;
    }
    else {
      return null;
    }
  }

  Future findMovies(String title) async {
    final String query = urlBase + urlSearch + urlKey + '&query=' + title;
    http.Response res = await http.get(query);
    if (res.statusCode == HttpStatus.ok) {
      final jsonResponse = json.decode(res.body);
      final moviesDynamic = jsonResponse['results'];
      List movies = moviesDynamic.map((i) =>
          Movie.fromJson(i)).toList();
      return movies;
    }
    else {
      return null;
    }
  }
}

