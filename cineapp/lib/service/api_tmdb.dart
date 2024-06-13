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
      throw Exception('Error al cargar las peliculas');
    }
  }

  Future<Map<String, dynamic>> fetchMovieDetails(int movieId) async {
    final response = await http.get(Uri.parse(
      '$baseUrl/movie/$movieId?api_key=$apiKey&append_to_response=videos&language=es-ES'
    ));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error al cargar los detalles');
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
      throw Exception('Error al cargar los actores');
    }
  }
}