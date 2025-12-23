class AnimeDetailDto {
  final int malId;
  final String title;
  final String? titleEnglish;
  final String imageUrl;
  final double score;
  final String synopsis;
  final String? trailerUrl;
  final int? year;
  final List<String> genres;
  final String studio;

  AnimeDetailDto({
    required this.malId,
    required this.title,
    required this.imageUrl,
    required this.score,
    required this.synopsis,
    this.titleEnglish,
    this.trailerUrl,
    this.year,
    required this.genres,
    required this.studio,
  });

  factory AnimeDetailDto.fromJson(Map<String, dynamic> json) {
    final data = json['data'];

    return AnimeDetailDto(
      malId: data['mal_id'],
      title: data['title'],
      titleEnglish: data['title_english'],
      imageUrl: data['images']['jpg']['large_image_url'],
      score: (data['score'] ?? 0).toDouble(),
      synopsis: data['synopsis'] ?? '',
      trailerUrl: data['trailer']?['embed_url'],
      year: data['aired']?['prop']?['from']?['year'],
      genres: (data['genres'] as List).map((e) => e['name'] as String).toList(),
      studio: (data['studios'] as List).isNotEmpty
          ? data['studios'][0]['name']
          : '',
    );
  }
}
