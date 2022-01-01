import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_provider.dart';
import 'package:movie_app/widgets/search_bar.dart';
import 'package:movie_app/widgets/search_data_tile.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    context.read<MovieData>().fetchSearchData;
    return Consumer<MovieData>(
      builder:(context, value, child) {
        return value.searchDataError == false ? Scaffold(
          backgroundColor: const Color(0xff151A23),
          appBar: AppBar(
            backgroundColor: const Color(0xff151A23),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.orangeAccent,
              ),
              onPressed: () {
                Navigator.pop(context);
                value.searchMapInitial();
              },
            ),
            title: SearchBar(
              visibility: false,
              searchController: searchController,
              onTap: () {
                value.query(searchController.text);
                value.fetchSearchData;
              },
              onBack: () {
                value.toggle;
                value.query("");
              },
            ),
            actions: [
              context.watch<MovieData>().pressed == false
                  ? GestureDetector(
            onTap: () {
              value.toggle;
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.search,
                color: Colors.orangeAccent,
              ),
            ),
          )
                  : Container()
            ],
          ),
          body: ListView.builder(
              itemCount: value.searchMap.isEmpty
                  ? 0
                  : value.searchMap['results'].length,
              itemBuilder: (context, index) {
                return SearchDataTile(
                  voteAverage: value.searchMap['results'][index]
                      ['vote_average'].toString(),
                  title: value.searchMap['results'][index]['original_title'],
                  description: value.searchMap['results'][index]['overview'],
                  urlToImage: 'https://image.tmdb.org/t/p/w500${value.searchMap['results'][index]['poster_path']}',
                );
              }),
          ) : const CircularProgressIndicator(
          color: Colors.orangeAccent,
        );
      }
    );
  }
}
