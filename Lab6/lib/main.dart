import 'package:flutter/material.dart';

// Step 2: Define the Movie Model
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

// Sample Data
final List<Movie> allMovies = [
  Movie(
    title: 'Inception',
    year: 2010,
    genres: ['Sci-Fi', 'Action'],
    posterUrl: 'https://images.unsplash.com/photo-1536440136628-849c177e76a1?q=80&w=500',
    rating: 8.8,
  ),
  Movie(
    title: 'The Dark Knight',
    year: 2008,
    genres: ['Action', 'Drama'],
    posterUrl: 'https://images.unsplash.com/photo-1478720568477-152d9b164e26?q=80&w=500',
    rating: 9.0,
  ),
  Movie(
    title: 'Interstellar',
    year: 2014,
    genres: ['Sci-Fi', 'Drama'],
    posterUrl: 'https://images.unsplash.com/photo-1446776811953-b23d57bd21aa?q=80&w=500',
    rating: 8.7,
  ),
  Movie(
    title: 'Dune: Part Two',
    year: 2024,
    genres: ['Sci-Fi', 'Adventure'],
    posterUrl: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?q=80&w=500',
    rating: 8.6,
  ),
  Movie(
    title: 'Deadpool & Wolverine',
    year: 2024,
    genres: ['Action', 'Comedy'],
    posterUrl: 'https://images.unsplash.com/photo-1509248961158-e54f6934749c?q=80&w=500',
    rating: 8.3,
  ),
  Movie(
    title: 'The Godfather',
    year: 1972,
    genres: ['Drama', 'Crime'],
    posterUrl: 'https://images.unsplash.com/photo-1594909122845-11baa439b7bf?q=80&w=500',
    rating: 9.2,
  ),
];

void main() {
  runApp(const ResponsiveMovieApp());
}

class ResponsiveMovieApp extends StatelessWidget {
  const ResponsiveMovieApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Responsive Movie Browser',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const GenreScreen(),
    );
  }
}

class GenreScreen extends StatefulWidget {
  const GenreScreen({super.key});

  @override
  State<GenreScreen> createState() => _GenreScreenState();
}

class _GenreScreenState extends State<GenreScreen> {
  // Step 4: Search state
  String _searchQuery = '';
  
  // Step 5: Genre state
  final List<String> _availableGenres = ['Action', 'Sci-Fi', 'Drama', 'Adventure', 'Comedy', 'Crime'];
  final Set<String> _selectedGenres = {};

  // Step 6: Sort state
  String _selectedSort = 'A-Z';
  final List<String> _sortOptions = ['A-Z', 'Z-A', 'Year', 'Rating'];

  // Step 7: Filtering and Sorting logic
  List<Movie> get _visibleMovies {
    List<Movie> filtered = allMovies.where((movie) {
      // Search filter
      final matchesSearch = movie.title.toLowerCase().contains(_searchQuery.toLowerCase());
      
      // Genre filter (OR logic)
      final matchesGenre = _selectedGenres.isEmpty || 
          movie.genres.any((g) => _selectedGenres.contains(g));
      
      return matchesSearch && matchesGenre;
    }).toList();

    // Sorting
    switch (_selectedSort) {
      case 'A-Z':
        filtered.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'Z-A':
        filtered.sort((a, b) => b.title.compareTo(a.title));
        break;
      case 'Year':
        filtered.sort((a, b) => b.year.compareTo(a.year));
        break;
      case 'Rating':
        filtered.sort((a, b) => b.rating.compareTo(a.rating));
        break;
    }
    
    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              // Step 3: Title Heading
              const Text(
                'Find a Movie',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),

              // Step 4: Responsive Search Bar
              TextField(
                onChanged: (value) => setState(() => _searchQuery = value),
                decoration: InputDecoration(
                  hintText: 'Search movie title...',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
              const SizedBox(height: 16),

              // Step 5: Genre Chips Using Wrap
              const Text('Genres', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: _availableGenres.map((genre) {
                  final isSelected = _selectedGenres.contains(genre);
                  return FilterChip(
                    label: Text(genre),
                    selected: isSelected,
                    onSelected: (selected) {
                      setState(() {
                        if (selected) {
                          _selectedGenres.add(genre);
                        } else {
                          _selectedGenres.remove(genre);
                        }
                      });
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Step 6: Sort Dropdown
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_visibleMovies.length} movies found',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  DropdownButton<String>(
                    value: _selectedSort,
                    items: _sortOptions.map((opt) {
                      return DropdownMenuItem(value: opt, child: Text('Sort by $opt'));
                    }).toList(),
                    onChanged: (val) {
                      if (val != null) setState(() => _selectedSort = val);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Step 8: Responsive Movie List (LayoutBuilder)
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (_visibleMovies.isEmpty) {
                      return const Center(child: Text('No movies match your filters.'));
                    }

                    if (constraints.maxWidth < 800) {
                      // Phone: Single-column list
                      return ListView.builder(
                        itemCount: _visibleMovies.length,
                        itemBuilder: (context, index) => MovieCard(
                          movie: _visibleMovies[index],
                          isGrid: false,
                        ),
                      );
                    } else {
                      // Tablet/Web: Two-column grid
                      return GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 2.5,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                        ),
                        itemCount: _visibleMovies.length,
                        itemBuilder: (context, index) => MovieCard(
                          movie: _visibleMovies[index],
                          isGrid: true,
                        ),
                      );
                    }
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
  final bool isGrid;

  const MovieCard({super.key, required this.movie, required this.isGrid});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: isGrid ? EdgeInsets.zero : const EdgeInsets.only(bottom: 16),
      clipBehavior: Clip.antiAlias,
      child: Row(
        children: [
          // Poster Image
          Image.network(
            movie.posterUrl,
            width: isGrid ? 100 : 120,
            height: isGrid ? 150 : 120,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => 
                Container(width: 100, color: Colors.grey, child: const Icon(Icons.broken_image)),
          ),
          const SizedBox(width: 12),
          // Movie Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  movie.title,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text('${movie.year} • ${movie.genres.join(", ")}', style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    const SizedBox(width: 4),
                    Text(movie.rating.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
