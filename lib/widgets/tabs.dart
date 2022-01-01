import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_provider.dart';
import 'package:movie_app/widgets/movie_tile.dart';
import 'package:provider/provider.dart';

class Tabs extends StatelessWidget {
  final String genre;

  const Tabs({
    Key? key,
    required this.genre,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int genre_id = 28;
    int i = 0;
    Provider.of<MovieData>(context).genreBasedMovie(genre);
    if (genre == 'Action'){
      genre_id = 28;
    } else if (genre == 'Fantasy') {
      genre_id = 14;
    } else if(genre == 'Adventure') {
      genre_id = 12;
    } else if(genre == 'Thriller') {
      genre_id = 53;
    } else if(genre == 'Comedy') {
      genre_id = 35;
    }
    return Consumer<MovieData>(
      builder: (context, value, child) {
        return value.actionMovie.isEmpty
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.orangeAccent,
                ),
              )
            : Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                height: 230,
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      while(i < value.movieMap['results'].length) {
                        if(value.movieMap['results'][index]['genre_ids'].contains(genre_id)) {
                          break;
                        } else {
                          index = index + 1;
                        }
                      }
                      // value.movieMap['results'][index]['genre_ids'].Contain(genre_id) ? continue; : index = index + 1;
                      return MovieTile(
                              desc: value.movieMap['results'][index]['overview'],
                              imgUrl: value.movieMap['results'][index]['backdrop_path'] != null ? 'https://image.tmdb.org/t/p/w500${value.movieMap['results'][index]['backdrop_path']}' : 'https://motivatevalmorgan.com/wp-content/uploads/2016/06/default-movie-1-3.jpg',
                              title: value.actionMovie[index].title,
                              rating: value.actionMovie[index].voteAverage,
                            );
                    }),
              );
      },
    );
  }
}
