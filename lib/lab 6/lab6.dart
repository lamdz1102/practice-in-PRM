import 'package:flutter/material.dart';

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Movie Browser',
      theme: ThemeData(
        colorSchemeSeed: Colors.deepPurple,
        useMaterial3: true,
      ),
      home: const GenreScreen(),
    );
  }
}

class Movie {
  final String title;
  final int year;
  final List<String> genres;
  final String posterUrl;
  final double rating;

  Movie({
    required this.title,
    required this.year,
    required this.genres,
    required this.posterUrl,
    required this.rating,
  });
}

final List<Movie> allMovies = [
  Movie(
    title: 'Avengers Endgame',
    year: 2019,
    genres: ['Action', 'Sci-Fi'],
    posterUrl:
    'https://picsum.photos/300/450?random=1',
    rating: 8.4,
  ),
  Movie(
    title: 'The Batman',
    year: 2022,
    genres: ['Action', 'Drama'],
    posterUrl:
    'https://picsum.photos/300/450?random=2',
    rating: 8.1,
  ),
  Movie(
    title: 'Joker',
    year: 2019,
    genres: ['Drama'],
    posterUrl:
    'https://picsum.photos/300/450?random=3',
    rating: 8.5,
  ),
  Movie(
    title: 'Toy Story',
    year: 1995,
    genres: ['Comedy'],
    posterUrl:
    'https://picsum.photos/300/450?random=4',
    rating: 8.3,
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: ['Sci-Fi', 'Drama'],
    posterUrl:
    'https://picsum.photos/300/450?random=5',
    rating: 8.7,
  ),
];

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  String searchQuery = '';
  String selectedSort = 'A-Z';

  final List<String> genres = [
    'Action',
    'Drama',
    'Comedy',
    'Sci-Fi',
  ];

  final Set<String> selectedGenres = {};

  @override
  Widget build(BuildContext context) {
    List<Movie> visibleMovies =
    allMovies.where((movie) {
      final matchSearch = movie.title
          .toLowerCase()
          .contains(searchQuery.toLowerCase());

      final matchGenre =
          selectedGenres.isEmpty ||
              movie.genres.any(
                    (genre) =>
                    selectedGenres.contains(genre),
              );

      return matchSearch && matchGenre;
    }).toList();

    switch (selectedSort) {
      case 'A-Z':
        visibleMovies.sort(
              (a, b) => a.title.compareTo(b.title),
        );
        break;

      case 'Z-A':
        visibleMovies.sort(
              (a, b) => b.title.compareTo(a.title),
        );
        break;

      case 'Year':
        visibleMovies.sort(
              (a, b) => b.year.compareTo(a.year),
        );
        break;

      case 'Rating':
        visibleMovies.sort(
              (a, b) => b.rating.compareTo(a.rating),
        );
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie Browser'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment:
            CrossAxisAlignment.start,
            children: [
              const Text(
                'Find a Movie',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              TextField(
                decoration: InputDecoration(
                  hintText: 'Search movie...',
                  prefixIcon:
                  const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                ),
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
              ),

              const SizedBox(height: 16),

              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: genres.map((genre) {
                  final isSelected =
                  selectedGenres.contains(genre);

                  return FilterChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (value) {
                      setState(() {
                        if (isSelected) {
                          selectedGenres.remove(genre);
                        } else {
                          selectedGenres.add(genre);
                        }
                      });
                    },
                  );
                }).toList(),
              ),

              const SizedBox(height: 16),

              DropdownButton<String>(
                value: selectedSort,
                isExpanded: true,
                items: const [
                  DropdownMenuItem(
                    value: 'A-Z',
                    child: Text('A-Z'),
                  ),
                  DropdownMenuItem(
                    value: 'Z-A',
                    child: Text('Z-A'),
                  ),
                  DropdownMenuItem(
                    value: 'Year',
                    child: Text('Year'),
                  ),
                  DropdownMenuItem(
                    value: 'Rating',
                    child: Text('Rating'),
                  ),
                ],
                onChanged: (value) {
                  setState(() {
                    selectedSort = value!;
                  });
                },
              ),

              const SizedBox(height: 12),

              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth < 800) {
                      return ListView.builder(
                        itemCount: visibleMovies.length,
                        itemBuilder: (context, index) {
                          return MovieCard(
                            movie: visibleMovies[index],
                          );
                        },
                      );
                    }

                    return GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 2.2,
                      children: visibleMovies
                          .map(
                            (movie) => MovieCard(
                          movie: movie,
                        ),
                      )
                          .toList(),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({
    super.key,
    required this.movie,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: LayoutBuilder(
          builder: (context, constraints) {
            double imageWidth =
            constraints.maxWidth > 500
                ? 120
                : 90;

            return Row(
              children: [
                Image.network(
                  movie.posterUrl,
                  width: imageWidth,
                  height: imageWidth * 1.4,
                  fit: BoxFit.cover,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Text(
                        movie.title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text('Year: ${movie.year}'),
                      Text('Rating: ${movie.rating}'),
                      Text(
                        movie.genres.join(', '),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}