class Movie {
  final String imdbId;
  final String title;
  final String poster;
  final String year;
  final String type;
  
  // Detailed fields (nullable because they aren't in the search list)
  final String? plot;
  final String? released;
  final String? genre;
  final String? imdbRating;

  Movie({
    required this.imdbId,
    required this.title,
    required this.poster,
    required this.year,
    required this.type,
    this.plot,
    this.released,
    this.genre,
    this.imdbRating,
  });

  // Factory for the Search List (Home Screen)
  factory Movie.fromJsonSearch(Map<String, dynamic> json) {
    return Movie(
      imdbId: json['imdbID'] ?? '',
      title: json['Title'] ?? 'Unknown',
      poster: json['Poster'] != 'N/A' ? json['Poster'] : '', // Handle missing images
      year: json['Year'] ?? '',
      type: json['Type'] ?? '',
    );
  }

  // Factory for Full Details (Detail Screen)
  factory Movie.fromJsonDetails(Map<String, dynamic> json) {
    return Movie(
      imdbId: json['imdbID'] ?? '',
      title: json['Title'] ?? 'Unknown',
      poster: json['Poster'] != 'N/A' ? json['Poster'] : '',
      year: json['Year'] ?? '',
      type: json['Type'] ?? '',
      plot: json['Plot'] ?? 'No description available',
      released: json['Released'] ?? 'Unknown',
      genre: json['Genre'] ?? 'Unknown',
      imdbRating: json['imdbRating'] ?? '0.0',
    );
  }
}