import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/movie_provider.dart';
import '../widgets/movie_card.dart';

class WatchlistTab extends StatelessWidget {
  const WatchlistTab({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);
    
    // Filter the current movie list to find matches in the watchlist
    final watchlistMovies = provider.movies
        .where((movie) => provider.isInWatchlist(movie.imdbId))
        .toList();
    
    if (watchlistMovies.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.playlist_add, size: 60, color: Colors.grey),
            SizedBox(height: 10),
            Text("No watchlist items in current search results"),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text("My Watchlist")),
      body: GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, 
          childAspectRatio: 0.7, 
          crossAxisSpacing: 10, 
          mainAxisSpacing: 10
        ),
        itemCount: watchlistMovies.length,
        itemBuilder: (context, index) => MovieCard(movie: watchlistMovies[index]),
      ),
    );
  }
}