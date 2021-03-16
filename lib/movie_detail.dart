import 'package:flutter/material.dart';

import 'movie_model.dart';

class MovieDetail extends StatelessWidget {
  final Movie movie;
  final String imgPath='https://image.tmdb.org/t/p/w500/';
  final defaultPath = 'https://images.freeimages.com/images/large-previews/5eb/movie-clapboard-1184339.jpg';

  const MovieDetail({Key key, this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    String path = movie.posterPath != null ? imgPath + movie.posterPath : defaultPath;
    return Scaffold(
      appBar: AppBar(
        title: Text(movie.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                  padding: EdgeInsets.all(16),
                  height: height / 1.5,
                  child:Image.network(path)
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(movie.overview),
              )
            ],
          ),
        ),
      ),
    );
  }
}
