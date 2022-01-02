import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_provider.dart';
import 'package:movie_app/widgets/movie_tile.dart';
import 'package:provider/provider.dart';

class TvShows extends StatelessWidget {
  const TvShows({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieData>(builder: (context, value, child) {
      return value.tvShowsMap.isEmpty && !value.tvShowDataError
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.orangeAccent,
            ))
          : Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Trending Tv Shows',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white38,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: value.tvShowsMap.isNotEmpty
                                ? value.tvShowsMap['results'].length
                                : 0,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return MovieTile(
                                desc: value.tvShowsMap['results'][index]
                                    ['overview'],
                                imgUrl: value.tvShowsMap['results'][index]
                                            ['backdrop_path'] !=
                                        null
                                    ? 'https://image.tmdb.org/t/p/w500${value.tvShowsMap['results'][index]['backdrop_path']}'
                                    : 'https://motivatevalmorgan.com/wp-content/uploads/2016/06/default-movie-1-3.jpg',
                                title: value.tvShowsMap['results'][index]
                                    ['original_name'],
                                rating: value.tvShowsMap['results'][index]
                                        ['vote_average']
                                    .toString(),
                              );
                            }),
                      ))
                ],
              ),
            );
    });
  }
}
