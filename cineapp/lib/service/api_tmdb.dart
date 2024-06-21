import 'dart:convert';
import 'package:cineapp/ApiKey/apikey.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = key;
  final String baseUrl = url;

  Future<List> fetchMoviesByCategory(String category) async {
    final response = await http.get(Uri.parse(
      '$baseUrl/movie/$category?api_key=$apiKey&language=es-ES'
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['results'];
    } else {
      throw Exception('Error al cargar las películas');
    }
  }

  Future<List> fetchMovieActors(int movieId) async {
    final response = await http.get(Uri.parse(
      '$baseUrl/movie/$movieId/credits?api_key=$apiKey&language=es-ES'
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['cast'];
    } else {
      throw Exception('Error al cargar los actores de la película');
    }
  }

  Future<Map<String, dynamic>> fetchMovieById(int movieId) async {
    final response = await http.get(Uri.parse(
      '$baseUrl/movie/$movieId?api_key=$apiKey&language=es-ES'
    ));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar la película');
    }
  }

  Future<Map<String, dynamic>> fetchMovieTrailer(int movieId) async {
    final response = await http.get(Uri.parse(
        '$baseUrl/movie/$movieId/videos?api_key=$apiKey&language=es-ES'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar la película');
    }
  }
}
