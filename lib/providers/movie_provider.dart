import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/movie.dart';
import '../services/api_service.dart';

class MovieProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<Movie> _movies = [];
  List<String> _favoriteIds = []; // Changed to String for OMDb
  List<String> _watchlistIds = [];
  
  bool _isLoading = false;
  String _errorMessage = '';

  List<Movie> get movies => _movies;
  // Note: For favorites/watchlist, in a real app you'd store the full object locally.
  // Here we filter the current list. (Limitation: Only shows favs if they are in current search results)
  // *Correction for Assignment*: We will just check IDs against the current list for display toggling.
  
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  MovieProvider() {
    loadLocalData();
    fetchDefaultMovies();
  }

  Future<void> fetchDefaultMovies() async {
    _isLoading = true;
    notifyListeners();
    try {
      _movies = await _apiService.getDefaultMovies();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchMovies(String query) async {
    if (query.isEmpty) {
      fetchDefaultMovies();
      return;
    }
    _isLoading = true;
    notifyListeners();
    try {
      _movies = await _apiService.searchMovies(query);
    } catch (e) {
      _errorMessage = "No movies found or network error";
      _movies = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Movie> getDetails(String id) async {
    return await _apiService.getMovieDetails(id);
  }

  // --- Local Storage Logic ---

  Future<void> loadLocalData() async {
    final prefs = await SharedPreferences.getInstance();
    _favoriteIds = prefs.getStringList('fav_ids') ?? [];
    _watchlistIds = prefs.getStringList('watch_ids') ?? [];
    notifyListeners();
  }

  void toggleFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    await prefs.setStringList('fav_ids', _favoriteIds);
    notifyListeners();
  }

  void toggleWatchlist(String id) async {
    final prefs = await SharedPreferences.getInstance();
    if (_watchlistIds.contains(id)) {
      _watchlistIds.remove(id);
    } else {
      _watchlistIds.add(id);
    }
    await prefs.setStringList('watch_ids', _watchlistIds);
    notifyListeners();
  }

  bool isFavorite(String id) => _favoriteIds.contains(id);
  bool isInWatchlist(String id) => _watchlistIds.contains(id);
}