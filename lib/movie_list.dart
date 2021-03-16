import 'package:flutter/material.dart';

import 'package:movies/http_helper.dart';
import 'package:movies/movie_detail.dart';
import 'movie_model.dart';

class MovieList extends StatefulWidget {
  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  Icon visibleIcon = Icon(Icons.search);
  Widget searchBar = Text('Movies');
  HttpHelper helper;
  bool isDirty;
  int moviesCount;
  List movies;

  Future search(String text) async {
    movies = await helper.findMovies(text);
    setState(() {
      moviesCount = movies.length;
      movies = movies;
    });
  }

  Future initialize() async {
    List upcoming = await helper.getUpcoming();
    setState(() {
      this.moviesCount = upcoming.length;
      this.movies = upcoming;
      this.isDirty = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: searchBar,
          centerTitle: true,
          actions: [
            IconButton(
                icon: visibleIcon,
                tooltip: 'Search',
                onPressed: () {
                  setState(() {
                    if (visibleIcon.icon == Icons.search) {
                      this.visibleIcon = Icon(Icons.cancel);
                      this.searchBar = TextField(
                        autofocus: true,
                        textInputAction: TextInputAction.search,
                        style: TextStyle(color: Colors.white, fontSize: 20.0),
                        onSubmitted: (query) {
                          search(query);
                          this.isDirty = true;
                        },
                      );
                    } else {
                      setState(() {
                        this.visibleIcon = Icon(Icons.search);
                        this.searchBar = Text('Movies');
                        if (isDirty) {
                          initialize();
                        }
                      });
                    }
                  });
                })
          ],
        ),
        body: ListView.builder(
            itemCount: (moviesCount == null) ? 0 : moviesCount,
            itemBuilder: (context, i) {
              Movie movie = movies[i];
              return Card(
                  color: Colors.white,
                  elevation: 2.0,
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(movie.posterPath != null
                            ? (HttpHelper.iconBase + movie.posterPath)
                            : HttpHelper.defaultImage),
                      ),
                      title: Text(movie.title),
                      subtitle: Text('Released: ' +
                          movie.releaseDate +
                          ' - Vote: ' +
                          movie.voteAverage.toString()),
                      onTap: () {
                        MaterialPageRoute route = MaterialPageRoute(
                            builder: (_) => MovieDetail(movie: movie));
                        Navigator.push(context, route);
                      }));
            }));
  }

  @override
  void initState() {
    this.helper = HttpHelper();
    initialize();
    super.initState();
  }
}
