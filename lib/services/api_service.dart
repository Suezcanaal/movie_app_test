import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
  static const String apiKey = '4b943484'; // YOUR KEY
  static const String baseUrl = 'http://www.omdbapi.com';

  // OMDb requires a search query. We'll use "Marvel" as the default landing page content.
  Future<List<Movie>> getDefaultMovies() async {
    return searchMovies('Marvel');
  }

  Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/?apikey=$apiKey&s=$query&type=movie'));
    
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['Response'] == "True") {
        return (data['Search'] as List).map((e) => Movie.fromJsonSearch(e)).toList();
      } else {
        // OMDb returns Response="False" if no movies found
        return [];
      }
    } else {
      throw Exception('Failed to load movies');
    }
  }

  // Fetch full details for a single movie using IMDb ID
  Future<Movie> getMovieDetails(String imdbId) async {
    final response = await http.get(Uri.parse('$baseUrl/?apikey=$apiKey&i=$imdbId'));
    
    if (response.statusCode == 200) {
      return Movie.fromJsonDetails(json.decode(response.body));
    } else {
      throw Exception('Failed to load details');
    }
  }
}