import 'package:cineapp/service/api_tmdb.dart';
import 'package:flutter/material.dart';

class MovieProvider with ChangeNotifier {
  List _popularMovies = [];
  List _topRatedMovies = [];
  List _nowPlayingMovies = []; 
  List _upComingMovies = [];
  List _actors = [];
  Map<String, dynamic> _selectedMovie = {};
  String _youtubeTrailerKey = '';

  List get popularMovies => _popularMovies;
  List get topRatedMovies => _topRatedMovies;
  List get nowPlayingMovies => _nowPlayingMovies;
  List get upComingMovies => _upComingMovies;
  List get actors => _actors;
  Map<String, dynamic> get selectedMovie => _selectedMovie;
  String get youtubeTrailerKey => _youtubeTrailerKey;

  void fetchMovies() async {
    _popularMovies = await ApiService().fetchMoviesByCategory('popular');
    _topRatedMovies = await ApiService().fetchMoviesByCategory('top_rated');
    _nowPlayingMovies = await ApiService().fetchMoviesByCategory('now_playing');
    _upComingMovies = await ApiService().fetchMoviesByCategory('upcoming');
    notifyListeners();
  }

  void fetchMovieDetails(int movieId) async {
    final movieDetails = await ApiService().fetchMovieDetails(movieId);
    _selectedMovie = movieDetails;

    // Obtener actores
    _actors = await ApiService().fetchMovieActors(movieId);

    // Obtener el tráiler de YouTube
    if (movieDetails['videos'] != null) {
      final videos = movieDetails['videos']['results'];
      for (var video in videos) {
        if (video['site'] == 'YouTube' && video['type'] == 'Trailer') {
          _youtubeTrailerKey = video['key'];
          break;
        }
      }
    }

    notifyListeners();
  }
}