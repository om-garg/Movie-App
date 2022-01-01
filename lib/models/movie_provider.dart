import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';

class MovieData with ChangeNotifier{
  Map<String, dynamic> _trendingMap = {};
  Map<String, dynamic> _movieMap = {};
  Map<String, dynamic> _trendingPersonMap = {};
  Map<String, dynamic> _tvShowsMap = {};
  Map<String, dynamic> _searchMap = {};
  bool _searchDataError = false;
  bool _movieDataError = false;
  bool _trendingDataError = false;
  bool _trendingPersonDataError = false;
  bool _tvShowDataError = false;
  String _errorMessage = "";
  String _searchQuery = "";
  List<MovieModel> _actionMovieList = [];

  bool _pressed = false;

  final _apiKey = '65d7c73a7103c959fda2eb145872db63';
  final _readAccessToken = 'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI2NWQ3YzczYTcxMDNjOTU5ZmRhMmViMTQ1ODcyZGI2MyIsInN1YiI6IjYxY2FjN2ZiMDcyOTFjMDAxY2Y3Y2NhYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.X0WFrkM8J3h3cpJY8oix-PPg4IAhjOhqMx7gbWmKzsk';

  Map<String, dynamic> get movieMap => _movieMap;
  Map<String, dynamic> get trendingMap => _trendingMap;
  Map<String, dynamic> get trendingPersonMap => _trendingPersonMap;
  Map<String, dynamic> get tvShowsMap => _tvShowsMap;
  Map<String, dynamic> get searchMap => _searchMap;

  bool get movieDataError => _movieDataError;
  bool get trendingDataError => _trendingDataError;
  bool get tvShowDataError => _tvShowDataError;
  bool get trendingPersonDataError => _trendingPersonDataError;
  bool get searchDataError => _searchDataError;
  String get errorMessage => _errorMessage;
  bool get pressed => _pressed;
  String get searchQuery => _searchQuery;
  List<MovieModel> get actionMovie => _actionMovieList;

  void get toggle{
    _pressed = !_pressed;
    notifyListeners();
  }
  void blankActionMap(){
    _actionMovieList = [];
  }
  void searchMapInitial() {
    _searchMap = {};
  }
  void query(String query){
    _searchQuery = query;
    notifyListeners();
  }
  Future<void> get fetchSearchData async {
    final searchResponse = await http.get(Uri.parse('https://api.themoviedb.org/3/search/movie?query=$_searchQuery&api_key=$_apiKey&page=2'));
    _searchMap = jsonDecode(searchResponse.body);

    if(searchResponse.statusCode == 200){
      try {
        _searchMap = jsonDecode(searchResponse.body);
        _searchDataError = false;
      } catch(e) {
        _searchDataError = true;
        _errorMessage = e.toString();
        _searchMap = {};
      }
    } else {
      _searchDataError = true;
      _errorMessage = "Error: It could be your internet connection.";
      _searchMap = {};
    }
    notifyListeners();
  }

  Future<void> genreBasedMovie(String genre) async{
    final movieResponse = await http.get(Uri.parse('https://api.themoviedb.org/3/search/movie?query=$genre&api_key=$_apiKey&page=2'));
    _movieMap = jsonDecode(movieResponse.body);

    if(movieResponse.statusCode == 200){
      try {
        _movieMap = jsonDecode(movieResponse.body);
        _movieDataError = false;
      } catch(e) {
        _movieDataError = true;
        _errorMessage = e.toString();
        _movieMap = {};
      }
    } else {
      _movieDataError = true;
      _errorMessage = "Error: It could be your internet connection.";
      _movieMap = {};
    }

    if(_movieMap == {}){
      _movieDataError = true;
    } else {
      _movieMap['results'].forEach((element){
        if (element['backdrop_path'] != null &&
            element['overview'] != null &&
            element['original_title'] != null && element['vote_average'] != null){
          MovieModel movieModel = MovieModel(
              title: element['original_title'],
              description: element['overview'],
              voteAverage: element['vote_average'].toString(),
              urlToImage: 'https://image.tmdb.org/t/p/w500${element['backdrop_path']}',
          );
          _actionMovieList.add(movieModel);
        }
      });
    }
    notifyListeners();
  }

  Future<void> get fetchTrendingData async {
    final trendingResponse = await http.get(Uri.parse('https://api.themoviedb.org/3/trending/all/day?api_key=$_apiKey'));
    _trendingMap = jsonDecode(trendingResponse.body);
    // print(_trendingMap);

    if(trendingResponse.statusCode == 200){
      try {
        _trendingMap = jsonDecode(trendingResponse.body);
        _trendingDataError = false;
      } catch(e) {
        _trendingDataError = true;
        _errorMessage = e.toString();
        _trendingMap = {};
      }
    } else {
      _trendingDataError = true;
      _errorMessage = "Error: It could be your internet connection.";
      _trendingMap = {};
    }
    notifyListeners();
  }

  Future<void> get fetchTrendingPersonData async {
    final trendingPersonsResponse = await http.get(Uri.parse('https://api.themoviedb.org/3/trending/person/day?api_key=$_apiKey'));
    _trendingPersonMap = jsonDecode(trendingPersonsResponse.body);
    // print(_trendingPersonMap);

    if(trendingPersonsResponse.statusCode == 200){
      try {
        _trendingPersonMap = jsonDecode(trendingPersonsResponse.body);
        _trendingPersonDataError = false;
      } catch(e) {
        _trendingPersonDataError = true;
        _errorMessage = e.toString();
        _trendingPersonMap = {};
      }
    } else {
      _trendingPersonDataError = true;
      _errorMessage = "Error: It could be your internet connection.";
      _trendingPersonMap = {};
    }
    notifyListeners();
  }

  Future<void> get fetchTvShowsData async {
    final tvShowsResponse = await http.get(Uri.parse('https://api.themoviedb.org/3/trending/tv/day?api_key=$_apiKey'));
    _tvShowsMap = jsonDecode(tvShowsResponse.body);
    // print(_tvShowsMap);

    if(tvShowsResponse.statusCode == 200){
      try {
        _tvShowsMap = jsonDecode(tvShowsResponse.body);
        _tvShowDataError = false;
      } catch(e) {
        _tvShowDataError = true;
        _errorMessage = e.toString();
        _tvShowsMap = {};
      }
    } else {
      _tvShowDataError = true;
      _errorMessage = "Error: It could be your internet connection.";
      _tvShowsMap = {};
    }
    notifyListeners();
  }
}