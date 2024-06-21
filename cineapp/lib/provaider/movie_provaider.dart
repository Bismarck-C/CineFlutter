import 'package:cineapp/service/api_tmdb.dart';
import 'package:flutter/material.dart';

class MovieProvider with ChangeNotifier {
  List<dynamic> _popularMovies = [];
  List<dynamic> _topRatedMovies = [];
  List<dynamic> _nowPlayingMovies = [];
  List<dynamic> _upComingMovies = [];
  List<dynamic> _actors = [];
  Map<String, dynamic> _selectedMovie = {};
  List<Map<String, dynamic>> _favoriteMovies = [];
  String _youtubeTrailerKey = '';

  List<dynamic> get popularMovies => _popularMovies;
  List<dynamic> get topRatedMovies => _topRatedMovies;
  List<dynamic> get nowPlayingMovies => _nowPlayingMovies;
  List<dynamic> get upComingMovies => _upComingMovies;
  List<dynamic> get actors => _actors;
  List<Map<String, dynamic>> get favoriteMovies => _favoriteMovies;
  Map<String, dynamic> get selectedMovie => _selectedMovie;
  String get youtubeTrailerKey => _youtubeTrailerKey;

  final ApiService _apiService = ApiService();

  Future<void> fetchPelicula() async {
    try {
      _popularMovies = await _apiService.fetchPeliculaByCategoria('popular');
      _topRatedMovies = await _apiService.fetchPeliculaByCategoria('top_rated');
      _nowPlayingMovies =
          await _apiService.fetchPeliculaByCategoria('now_playing');
      _upComingMovies = await _apiService.fetchPeliculaByCategoria('upcoming');
      notifyListeners();
    } catch (e) {
      print(e);
      // Puedes manejar el error de otra manera si es necesario
    }
  }

  Future<void> fetchPeliculaDetalle(int movieId) async {
    try {
      final movieDetails = await _apiService.fetchPeliculaById(movieId);
      _selectedMovie = movieDetails;

      _actors = await _apiService.fetchActores(movieId);
      final videos = await _apiService.fetchPeliculaTrailer(movieId);
      _youtubeTrailerKey = _findYoutubeTrailerKey(videos);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  String _findYoutubeTrailerKey(Map<String, dynamic> videos) {
    if (videos['results'] != null) {
      for (var video in videos["results"]) {
        if (video['site'] == 'YouTube' && video['type'] == 'Trailer') {
          return video['key'];
        }
      }
    }
    return ''; // Retornar una cadena vacía si no se encuentra ningún trailer de YouTube
  }

  void addFavoriteMovie(Map<String, dynamic> movie) {
    if (!_favoriteMovies.any((m) => m['id'] == movie['id'])) {
      _favoriteMovies.add(movie);
      notifyListeners();
    }
  }
  void removeFavoriteMovie(int movieId) {
    _favoriteMovies.removeWhere((movie) => movie['id'] == movieId);
    notifyListeners();
  }
   bool isFavorite(int movieId) {
    return _favoriteMovies.any((movie) => movie['id'] == movieId);
  }
  
}
