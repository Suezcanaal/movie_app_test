import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../models/movie.dart';
import '../providers/movie_provider.dart';

class MovieDetailScreen extends StatefulWidget {
  final String imdbId;
  const MovieDetailScreen({super.key, required this.imdbId});

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late Future<Movie> _movieDetailFuture;

  @override
  void initState() {
    super.initState();
    // Fetch full details using the ID
    _movieDetailFuture = Provider.of<MovieProvider>(context, listen: false).getDetails(widget.imdbId);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);
    final isFav = provider.isFavorite(widget.imdbId);
    final isWatch = provider.isInWatchlist(widget.imdbId);

    return Scaffold(
      body: FutureBuilder<Movie>(
        future: _movieDetailFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error loading details"));
          } else if (!snapshot.hasData) {
            return Center(child: Text("No Data"));
          }

          final movie = snapshot.data!;
          // Parse IMDB rating to double safely
          double rating = double.tryParse(movie.imdbRating ?? '0') ?? 0.0;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 400,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  title: Text(movie.title, style: TextStyle(fontSize: 16, shadows: [Shadow(blurRadius: 10, color: Colors.black)])),
                  background: movie.poster.isNotEmpty
                      ? CachedNetworkImage(imageUrl: movie.poster, fit: BoxFit.cover)
                      : Container(color: Colors.grey),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CircularPercentIndicator(
                              radius: 30.0,
                              lineWidth: 5.0,
                              percent: (rating / 10).clamp(0.0, 1.0),
                              center: Text("$rating"),
                              progressColor: Colors.amber,
                              footer: Text("IMDb Score", style: TextStyle(fontSize: 12)),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: Colors.red),
                                  onPressed: () => provider.toggleFavorite(movie.imdbId),
                                ),
                                IconButton(
                                  icon: Icon(isWatch ? Icons.playlist_add_check : Icons.playlist_add, color: Colors.blue),
                                  onPressed: () => provider.toggleWatchlist(movie.imdbId),
                                ),
                              ],
                            )
                          ],
                        ),
                        SizedBox(height: 20),
                        _buildInfoRow("Released", movie.released ?? 'N/A'),
                        _buildInfoRow("Genre", movie.genre ?? 'N/A'),
                        SizedBox(height: 20),
                        Text("Overview", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                        SizedBox(height: 5),
                        Text(movie.plot ?? 'No plot available', style: TextStyle(color: Colors.white70)),
                        SizedBox(height: 30),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.play_arrow),
                            label: Text("Play Now"),
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              backgroundColor: Colors.redAccent,
                            ),
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Movie is Playing"),
                                  behavior: SnackBarBehavior.floating,
                                  backgroundColor: Colors.green,
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title: ", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
          Expanded(child: Text(value, style: TextStyle(color: Colors.white70))),
        ],
      ),
    );
  }
}