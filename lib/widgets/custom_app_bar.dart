import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_provider.dart';
import 'package:movie_app/screens/search_screen.dart';
import 'package:movie_app/widgets/search_bar.dart';
import 'package:movie_app/widgets/trending_tile.dart';
import 'package:provider/provider.dart';

import 'brand_name.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = TextEditingController();
    return Consumer<MovieData>(
      builder: (context, value, child) {
        return SliverAppBar(
          floating: true,
          snap: true,
          backgroundColor: const Color(0xff151A23),
          leading: value.pressed == false
              ? const Opacity(
                  opacity: 0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Icon(
                      Icons.save,
                    ),
                  ),
                )
              : null,
          title: Stack(
            children: [
              value.pressed == false
                  ? const BrandName()
                  : SearchBar(
                      searchController: searchController,
                      onTap: () {
                        value.query(searchController.text);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SearchScreen()));
                      },
                      onBack: () {
                        value.toggle;
                        searchController.text = "";
                        value.query("");
                      },
                    ),
              // BrandName(),
            ],
          ),
          actions: [
            value.pressed == false
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(245),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  width: MediaQuery.of(context).size.width,
                  child: const Center(child: TrendingTile()),
                ),
                const SizedBox(
                  height: 15,
                ),
                const TabBar(
                  isScrollable: true,
                  indicatorColor: Colors.orangeAccent,
                  unselectedLabelColor: Colors.white38,
                  tabs: [
                    Text(
                      "Action",
                      style: TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      "Fantasy",
                      style: TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      "Adventure",
                      style: TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      "Thriller",
                      style: TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      "Comedy",
                      style: TextStyle(
                        fontFamily: 'Overpass',
                        fontSize: 17,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
