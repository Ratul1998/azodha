class AnimeModel {
  final int id;
  final String title;
  final String imageUrl;
  final double score;
  final String type;
  final String? subtitle;
  final String? description;

  const AnimeModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.score,
    required this.type,
    this.subtitle,
    this.description,
  });

  factory AnimeModel.dummy() => AnimeModel(
    id: 0,
    title: 'title',
    imageUrl: 'imageUrl',
    score: 100,
    type: 'type',
  );
}
