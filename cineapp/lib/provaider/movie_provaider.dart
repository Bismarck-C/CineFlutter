import 'package:cineapp/service/api_tmdb.dart';
import 'package:flutter/material.dart';

class MovieProvider with ChangeNotifier {
  List<dynamic> _popularMovies = [];
  List<dynamic> _topRatedMovies = [];
  List<dynamic> _nowPlayingMovies = [];
  List<dynamic> _upComingMovies = [];
  List<dynamic> _actors = [];
  Map<String, dynamic> _selectedMovie = {};
  String _youtubeTrailerKey = '';

  List<dynamic> get popularMovies => _popularMovies;
  List<dynamic> get topRatedMovies => _topRatedMovies;
  List<dynamic> get nowPlayingMovies => _nowPlayingMovies;
  List<dynamic> get upComingMovies => _upComingMovies;
  List<dynamic> get actors => _actors;
  Map<String, dynamic> get selectedMovie => _selectedMovie;
  String get youtubeTrailerKey => _youtubeTrailerKey;

  final ApiService _apiService = ApiService();

  Future<void> fetchMovies() async {
    try {
      _popularMovies = await _apiService.fetchMoviesByCategory('popular');
      _topRatedMovies = await _apiService.fetchMoviesByCategory('top_rated');
      _nowPlayingMovies = await _apiService.fetchMoviesByCategory('now_playing');
      _upComingMovies = await _apiService.fetchMoviesByCategory('upcoming');
      notifyListeners();
    } catch (e) {
      print(e);
      // Puedes manejar el error de otra manera si es necesario
    }
  }

  Future<void> fetchMovieDetails(int movieId) async {
  try {
    final movieDetails = await _apiService.fetchMovieById(movieId);
    _selectedMovie = movieDetails;

    _actors = await _apiService.fetchMovieActors(movieId);

    _youtubeTrailerKey = _findYoutubeTrailerKey(movieDetails);

    notifyListeners();
  } catch (e) {
    print(e);
  }
}

  String _findYoutubeTrailerKey(Map<String, dynamic> movieDetails) {
    if (movieDetails['videos'] != null) {
      final videos = movieDetails['videos']['results'];
      for (var video in videos) {
        if (video['site'] == 'YouTube' && video['type'] == 'Trailer') {
          return 'https://www.youtube.com/watch?v=${video['key']}';
        }
      }
    }
    return ''; // Retornar una cadena vacía si no se encuentra ningún trailer de YouTube
  }
}
