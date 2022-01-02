import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_provider.dart';
import 'package:movie_app/widgets/custom_app_bar.dart';
import 'package:movie_app/widgets/trending_people_list.dart';
import 'package:movie_app/widgets/tv_shows.dart';
import 'package:provider/provider.dart';
import 'package:movie_app/widgets/tabs.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    context.read<MovieData>().fetchTrendingData;
    context.read<MovieData>().fetchTrendingPersonData;
    context.read<MovieData>().fetchTvShowsData;
    context.read<MovieData>().actionMovieData;
    context.read<MovieData>().fantasyMovieData;
    context.read<MovieData>().comedyMovieData;
    context.read<MovieData>().thrillerMovieData;
    context.read<MovieData>().adventureMovieData;
    return DefaultTabController(
      length: 5,
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xff151A23),
          body: RefreshIndicator(
            onRefresh: () async {
              await context.read<MovieData>().fetchTrendingData;
              await context.read<MovieData>().fetchTrendingPersonData;
              await context.read<MovieData>().fetchTvShowsData;
            },
            color: Colors.orangeAccent,
            backgroundColor: const Color(0xff151A23),
            child: NestedScrollView(
              headerSliverBuilder: (context, innerBoxIsScrolled) =>
                  [const CustomAppBar()],
              body: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 4,
                    child: TabBarView(
                      children: [
                        context.watch<MovieData>().movieDataError == true
                            ? const CircularProgressIndicator()
                            : const Tabs(
                                genre: 'Action',
                              ),
                        context.watch<MovieData>().movieDataError == true
                            ? const CircularProgressIndicator()
                            : const Tabs(
                                genre: 'Fantasy',
                              ),
                        context.watch<MovieData>().movieDataError == true
                            ? const CircularProgressIndicator()
                            : const Tabs(
                                genre: 'Adventure',
                              ),
                        context.watch<MovieData>().movieDataError == true
                            ? const CircularProgressIndicator()
                            : const Tabs(
                                genre: 'Thriller',
                              ),
                        context.watch<MovieData>().movieDataError == true
                            ? const CircularProgressIndicator()
                            : const Tabs(
                                genre: 'Comedy',
                              ),
                      ],
                    ),
                  ),
                  const Expanded(
                    flex: 2,
                    child: TrendingPeopleList(),
                  ),
                  const Expanded(
                    flex: 4,
                    child: TvShows(),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
