import 'movie.dart';

final List<Movie> movies = [
  Movie(
    id: 1,
    title: 'Dune: Part Two',
    posterUrl: 'https://picsum.photos/id/1011/600/400',
    overview:
    'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    rating: 8.6,
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    trailers: [
      'Official Trailer #1',
      'IMAX Sneak Peek',
      'Final Trailer',
    ],
  ),
  Movie(
    id: 2,
    title: 'Deadpool & Wolverine',
    posterUrl: 'https://picsum.photos/id/1025/600/400',
    overview:
    'The multiverse gets messy when Wade Wilson teams up with Wolverine for a not-so-family-friendly mission.',
    rating: 8.3,
    genres: ['Action', 'Comedy'],
    trailers: [
      'Red Band Trailer',
      'Behind the Scenes',
      'Teaser Trailer',
    ],
  ),
  Movie(
    id: 3,
    title: 'Inside Out 2',
    posterUrl: 'https://picsum.photos/id/1035/600/400',
    overview:
    'Riley enters her teenage years and discovers new emotions that make her life more complicated and colorful.',
    rating: 7.9,
    genres: ['Animation', 'Family', 'Comedy'],
    trailers: [
      'Official Trailer',
      'Meet the Emotions',
      'Sneak Peek',
    ],
  ),
];