import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_card.dart';

class FavoritesTab extends StatelessWidget {
  const FavoritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the provider to get the full list and the favorite IDs
    final provider = Provider.of<MovieProvider>(context);
    
    // Filter the current movie list to find matches in the favorites list
    // Note: Since we only store IDs, this only shows favorites that are currently visible in the search results.
    final favoriteMovies = provider.movies
        .where((movie) => provider.isFavorite(movie.imdbId))
        .toList();
    
    if (favoriteMovies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.favorite_border, size: 60, color: Colors.grey),
            SizedBox(height: 10),
            Text("No favorites found in current search results"),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("My Favorites")),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          childAspectRatio: 0.7, 
          crossAxisSpacing: 10, 
          mainAxisSpacing: 10
        ),
        itemCount: favoriteMovies.length,
        itemBuilder: (context, index) => MovieCard(movie: favoriteMovies[index]),
      ),
    );
  }
}