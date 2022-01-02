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
    context.read<MovieData>().actionMovieData;
    context.read<MovieData>().fantasyMovieData;
    context.read<MovieData>().comedyMovieData;
    context.read<MovieData>().thrillerMovieData;
    context.read<MovieData>().adventureMovieData;
    return Consumer<MovieData>(
      builder: (context, value, child) {
        return value.actionMovie.isEmpty ||
                value.fantasyMovie.isEmpty ||
                value.adventureMovie.isEmpty ||
                value.comedyMovie.isEmpty ||
                value.thrillerMovie.isEmpty
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
                    itemCount: genre == 'Action'
                        ? value.actionMovie.length
                        : genre == 'Fantasy'
                            ? value.fantasyMovie.length
                            : genre == 'Adventure'
                                ? value.adventureMovie.length
                                : genre == 'Thriller'
                                    ? value.thrillerMovie.length
                                    : value.comedyMovie.length,
                    itemBuilder: (context, index) {
                      return MovieTile(
                        desc: genre == 'Action'
                            ? value.actionMovie[index].description
                            : genre == 'Fantasy'
                                ? value.fantasyMovie[index].description
                                : genre == 'Adventure'
                                    ? value.adventureMovie[index].description
                                    : genre == 'Thriller'
                                        ? value.thrillerMovie[index].description
                                        : value.comedyMovie[index].description,
                        imgUrl: genre == 'Action'
                            ? value.actionMovie[index].urlToImage
                            : genre == 'Fantasy'
                                ? value.fantasyMovie[index].urlToImage
                                : genre == 'Adventure'
                                    ? value.adventureMovie[index].urlToImage
                                    : genre == 'Thriller'
                                        ? value.thrillerMovie[index].urlToImage
                                        : value.comedyMovie[index].urlToImage,
                        title: genre == 'Action'
                            ? value.actionMovie[index].title
                            : genre == 'Fantasy'
                                ? value.fantasyMovie[index].title
                                : genre == 'Adventure'
                                    ? value.adventureMovie[index].title
                                    : genre == 'Thriller'
                                        ? value.thrillerMovie[index].title
                                        : value.comedyMovie[index].title,
                        rating: genre == 'Action'
                            ? value.actionMovie[index].voteAverage
                            : genre == 'Fantasy'
                                ? value.fantasyMovie[index].voteAverage
                                : genre == 'Adventure'
                                    ? value.adventureMovie[index].voteAverage
                                    : genre == 'Thriller'
                                        ? value.thrillerMovie[index].voteAverage
                                        : value.comedyMovie[index].voteAverage,
                      );
                    }),
              );
      },
    );
  }
}
