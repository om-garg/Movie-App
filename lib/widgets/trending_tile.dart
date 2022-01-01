import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_provider.dart';
import 'package:movie_app/screens/detail_screen.dart';
import 'package:page_indicator/page_indicator.dart';
import 'package:provider/provider.dart';

class TrendingTile extends StatelessWidget {
  const TrendingTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieData>(
      builder: (context, value, child) {
        return value.trendingMap.isEmpty && !value.trendingDataError
            ? const CircularProgressIndicator(
                color: Colors.orangeAccent,
              )
            : PageIndicatorContainer(
                length: 8,
                shape: IndicatorShape.circle(size: 5),
                align: IndicatorAlign.bottom,
                padding: const EdgeInsets.all(5),
                indicatorColor: Colors.white,
                indicatorSelectorColor: Colors.orangeAccent,
                // child: Container(),
                child: PageView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(
                            builder: (context) => DetailScreen(
                              rating: value.trendingMap['results'][index]['vote_average'].toString(),
                              imageUrl: value.trendingMap['results'][index]['backdrop_path'],
                              title: value.trendingMap['results'][index]['original_title'],
                              description: value.trendingMap['results'][index]['overview'],
                            )));
                      },
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: NetworkImage( value.trendingMap['results'][index]['backdrop_path'] != null ?
                                      "https://image.tmdb.org/t/p/w500${value.trendingMap['results'][index]['backdrop_path']}" : 'https://motivatevalmorgan.com/wp-content/uploads/2016/06/default-movie-1-3.jpg'),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          Container(
                            child: Stack(
                              children: [
                                const Center(
                                  child: Icon(
                                    Icons.play_circle_outline_sharp,
                                    color: Colors.orangeAccent,
                                    size: 50,
                                  ),
                                ),
                                Positioned(
                                  left: 10,
                                  top: 140,
                                  child: Container(
                                    width: 400,
                                    child: Text(
                                      value.trendingMap['results'][index]
                                          ['original_title'],
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                              colors: [
                                const Color(0xff151A23).withOpacity(1),
                                const Color(0xff151A23).withOpacity(0.7),
                                const Color(0xff151A23).withOpacity(0),
                              ],
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                            )),
                          )
                        ],
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
