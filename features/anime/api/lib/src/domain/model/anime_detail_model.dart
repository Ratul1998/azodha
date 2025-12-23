class AnimeDetailModel {
  final int id;
  final String title;
  final String imageUrl;
  final double score;
  final int year;
  final List<String> genres;
  final String studio;
  final String synopsis;
  final String? trailerUrl;

  const AnimeDetailModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.score,
    required this.year,
    required this.genres,
    required this.studio,
    required this.synopsis,
    this.trailerUrl,
  });
}
