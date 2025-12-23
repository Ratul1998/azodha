class AnimeResponseModel {
  final Pagination pagination;
  final List<AnimeListModel> data;

  const AnimeResponseModel({required this.data, required this.pagination});

  factory AnimeResponseModel.fromJson(Map<String, dynamic> json) {
    return AnimeResponseModel(
      pagination: Pagination.fromJson(json['pagination']),
      data:
          (json['data'] as List<dynamic>?)
              ?.map((data) => AnimeListModel.fromJson(data))
              .toList() ??
          [],
    );
  }
}

class Pagination {
  final int lastVisiblePage;
  final bool hasNextPage;
  final int currentPage;
  final PaginationItems items;

  Pagination({
    required this.lastVisiblePage,
    required this.hasNextPage,
    required this.currentPage,
    required this.items,
  });

  factory Pagination.fromJson(Map<String, dynamic> json) {
    return Pagination(
      lastVisiblePage: json['last_visible_page'] ?? 0,
      hasNextPage: json['has_next_page'] ?? false,
      currentPage: json['current_page'] ?? 1,
      items: PaginationItems.fromJson(json['items'] ?? {}),
    );
  }
}

class PaginationItems {
  final int count;
  final int total;
  final int perPage;

  PaginationItems({
    required this.count,
    required this.total,
    required this.perPage,
  });

  factory PaginationItems.fromJson(Map<String, dynamic> json) {
    return PaginationItems(
      count: json['count'] ?? 0,
      total: json['total'] ?? 0,
      perPage: json['per_page'] ?? 0,
    );
  }
}

class AnimeListModel {
  final int malId;
  final String title;
  final String? titleEnglish;
  final String? titleJapanese;
  final String image;
  final String type;
  final int? episodes;
  final String status;
  final double score;
  final String synopsis;
  final String rating;
  final String duration;
  final AiredDate? aired;
  final List<AnimeGenre> genres;
  final List<AnimeStudio> studios;

  AnimeListModel({
    required this.malId,
    required this.title,
    required this.image,
    required this.type,
    required this.status,
    required this.score,
    required this.synopsis,
    required this.rating,
    required this.duration,
    this.titleEnglish,
    this.titleJapanese,
    this.episodes,
    this.aired,
    required this.genres,
    required this.studios,
  });

  factory AnimeListModel.fromJson(Map<String, dynamic> json) {
    return AnimeListModel(
      malId: json['mal_id'],
      title: json['title'],
      titleEnglish: json['title_english'],
      titleJapanese: json['title_japanese'],
      image: json['images']['jpg']['large_image_url'],
      type: json['type'],
      episodes: json['episodes'],
      status: json['status'],
      score: (json['score'] ?? 0).toDouble(),
      synopsis: json['synopsis'] ?? '',
      rating: json['rating'] ?? '',
      duration: json['duration'] ?? '',
      aired: json['aired'] != null ? AiredDate.fromJson(json['aired']) : null,
      genres: (json['genres'] as List)
          .map((e) => AnimeGenre.fromJson(e))
          .toList(),
      studios: (json['studios'] as List)
          .map((e) => AnimeStudio.fromJson(e))
          .toList(),
    );
  }
}

class AiredDate {
  final DateTime? from;
  final String string;

  AiredDate({this.from, required this.string});

  factory AiredDate.fromJson(Map<String, dynamic> json) {
    return AiredDate(
      from: json['from'] != null ? DateTime.parse(json['from']) : null,
      string: json['string'] ?? '',
    );
  }
}

class AnimeGenre {
  final int id;
  final String name;

  AnimeGenre({required this.id, required this.name});

  factory AnimeGenre.fromJson(Map<String, dynamic> json) {
    return AnimeGenre(id: json['mal_id'], name: json['name']);
  }
}

class AnimeStudio {
  final int id;
  final String name;

  AnimeStudio({required this.id, required this.name});

  factory AnimeStudio.fromJson(Map<String, dynamic> json) {
    return AnimeStudio(id: json['mal_id'], name: json['name']);
  }
}
