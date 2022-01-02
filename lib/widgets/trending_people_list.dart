import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_provider.dart';
import 'package:movie_app/widgets/person_tile.dart';
import 'package:provider/provider.dart';

class TrendingPeopleList extends StatelessWidget {
  const TrendingPeopleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieData>(builder: (context, value, child) {
      return value.trendingPersonMap.isEmpty && !value.trendingPersonDataError
          ? const Center(
              child: CircularProgressIndicator(
              color: Colors.orangeAccent,
            ))
          : Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Trending People',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white38,
                        fontSize: 18,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Expanded(
                    flex: 1,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: value.trendingPersonMap.isNotEmpty
                            ? value.trendingPersonMap['results'].length
                            : 0,
                        itemBuilder: (context, index) {
                          return PersonTile(
                            imgUrl: value.trendingPersonMap['results'][index]['profile_path'] != null ?
                                'https://image.tmdb.org/t/p/w500${value.trendingPersonMap['results'][index]['profile_path']}' : 'https://motivatevalmorgan.com/wp-content/uploads/2016/06/default-movie-1-3.jpg',
                            name: value.trendingPersonMap['results'][index]
                                ['name'],
                          );
                        }),
                  )
                ],
              ),
            );
    });
  }
}
