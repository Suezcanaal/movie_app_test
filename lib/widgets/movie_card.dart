import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/movie.dart';
import '../screens/movie_detail_screen.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MovieDetailScreen(imdbId: movie.imdbId)));
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          footer: GridTileBar(
            backgroundColor: Colors.black54,
            title: Text(movie.title, textAlign: TextAlign.center),
            subtitle: Text(movie.year), // Display Year/Category logic here
          ),
          child: movie.poster.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: movie.poster,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => Icon(Icons.broken_image),
                )
              : Container(color: Colors.grey, child: Icon(Icons.movie, size: 50)),
        ),
      ),
    );
  }
}