import 'package:flutter/material.dart';
import 'package:movie_desktop_app/pages/home/video_screen.dart';

import '../../models/movie_model.dart';
import '../media_screen.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;

  const MovieCard({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => openVideo(context),
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: movie.posterPath.isNotEmpty
                  ? Image.network(
                      'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(child: Icon(Icons.error));
                      },
                    )
                  : const Center(child: Icon(Icons.movie)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: Theme.of(context).textTheme.titleMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.star, size: 16, color: Colors.amber),
                      const SizedBox(width: 4),
                      Expanded(child: Text(movie.voteCount.toStringAsFixed(1))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void openVideo(context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MediaScreen(),
      ),
    );
  }
}
