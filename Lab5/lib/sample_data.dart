import 'movie.dart';

final List<Movie> sampleMovies = [
  Movie(
    id: 1,
    title: 'Dune: Part Two',
    posterUrl: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?q=80&w=500',
    overview: 'Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.',
    genres: ['Sci-Fi', 'Adventure', 'Drama'],
    rating: 8.6,
    trailers: ['Official Trailer #1', 'IMAX Sneak Peek'],
  ),
  Movie(
    id: 2,
    title: 'Deadpool & Wolverine',
    posterUrl: 'https://images.unsplash.com/photo-1509248961158-e54f6934749c?q=80&w=500',
    overview: 'A weary Wolverine finds himself recovering from his injuries when he comes across a loudmouth Deadpool.',
    genres: ['Action', 'Comedy', 'Adventure'],
    rating: 8.3,
    trailers: ['Red Band Trailer', 'Behind the Scenes'],
  ),
  Movie(
    id: 3,
    title: 'Interstellar',
    posterUrl: 'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?q=80&w=500',
    overview: 'The adventures of a group of explorers who make use of a newly discovered wormhole to surpass the limitations on human space travel.',
    genres: ['Sci-Fi', 'Drama', 'Adventure'],
    rating: 8.7,
    trailers: ['Teaser Trailer', 'Final Trailer'],
  ),
];
