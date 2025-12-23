class AnimeSearchRequest {
  // Pagination
  final int? page;
  final int? limit;

  // Search
  final String? query;
  final String? letter;

  // Filters
  final AnimeType? type;
  final AnimeStatus? status;
  final AnimeRating? rating;

  final double? minScore;
  final double? maxScore;

  final List<int>? genres;
  final List<int>? genresExclude;
  final List<int>? producers;

  final DateTime? startDate;
  final DateTime? endDate;

  final AnimeOrderBy? orderBy;
  final SortDirection? sort;

  final bool unapproved;
  final bool sfw;

  const AnimeSearchRequest({
    this.page,
    this.limit,
    this.query,
    this.letter,
    this.type,
    this.status,
    this.rating,
    this.minScore,
    this.maxScore,
    this.genres,
    this.genresExclude,
    this.producers,
    this.startDate,
    this.endDate,
    this.orderBy,
    this.sort,
    this.unapproved = false,
    this.sfw = false,
  });

  /// Converts model to query params
  Map<String, String> toQueryParams() {
    final Map<String, String> params = {};

    if (page != null) params['page'] = page.toString();
    if (limit != null) params['limit'] = limit.toString();

    if (query != null && query!.isNotEmpty) params['q'] = query!;
    if (letter != null && letter!.isNotEmpty) params['letter'] = letter!;

    if (type != null) params['type'] = type!.value;
    if (status != null) params['status'] = status!.value;
    if (rating != null) params['rating'] = rating!.value;

    if (minScore != null) params['min_score'] = minScore.toString();
    if (maxScore != null) params['max_score'] = maxScore.toString();

    if (genres != null && genres!.isNotEmpty) {
      params['genres'] = genres!.join(',');
    }

    if (genresExclude != null && genresExclude!.isNotEmpty) {
      params['genres_exclude'] = genresExclude!.join(',');
    }

    if (producers != null && producers!.isNotEmpty) {
      params['producers'] = producers!.join(',');
    }

    if (startDate != null) {
      params['start_date'] = _formatDate(startDate!);
    }

    if (endDate != null) {
      params['end_date'] = _formatDate(endDate!);
    }

    if (orderBy != null) params['order_by'] = orderBy!.value;
    if (sort != null) params['sort'] = sort!.value;

    // Flags
    if (unapproved) params['unapproved'] = '';
    if (sfw) params['sfw'] = 'true';

    return params;
  }

  String _formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }
}

enum AnimeType { tv, movie, ova, special, ona, music, cm, pv, tvSpecial }

extension AnimeTypeX on AnimeType {
  String get value {
    switch (this) {
      case AnimeType.tvSpecial:
        return 'tv_special';
      default:
        return name;
    }
  }
}

enum AnimeStatus { airing, complete, upcoming }

enum AnimeRating { g, pg, pg13, r17, r, rx }

extension AnimeStatusX on AnimeStatus {
  String get value => name;
}

extension AnimeRatingX on AnimeRating {
  String get value => name;
}

enum AnimeOrderBy {
  malId,
  title,
  startDate,
  endDate,
  episodes,
  score,
  scoredBy,
  rank,
  popularity,
  members,
}

extension AnimeOrderByX on AnimeOrderBy {
  String get value {
    switch (this) {
      case AnimeOrderBy.malId:
        return 'mal_id';
      case AnimeOrderBy.startDate:
        return 'start_date';
      case AnimeOrderBy.endDate:
        return 'end_date';
      case AnimeOrderBy.scoredBy:
        return 'scored_by';
      default:
        return name;
    }
  }
}

enum SortDirection { asc, desc }

extension SortDirectionX on SortDirection {
  String get value => name;
}
