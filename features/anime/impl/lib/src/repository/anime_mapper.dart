import 'package:anime_impl/src/service/data/anime_details_dto.dart';
import 'package:anime_impl/src/service/data/anime_search_request_model.dart';
import 'package:anime_impl/src/service/data/api_response_model.dart';
import 'package:anime_api/api.dart';

class AnimeMapper {
  AnimePageModel mapDto(AnimeResponseModel dto) => AnimePageModel(
    pageNumber: dto.pagination.currentPage,
    totalItems: dto.pagination.items.total,
    searchResult: dto.data.map(_fromResponse).toList(),
  );

  AnimeSearchRequest mapRequest({
    int page = 1,
    int limit = 15,
    String query = '',
    AnimeStatus? status,
    AnimeType type = AnimeType.movie,
  }) => AnimeSearchRequest(
    query: query,
    page: page,
    limit: limit,
    status: status,
    type: type,
  );

  AnimeDetailModel fromDto(AnimeDetailDto dto) {
    return AnimeDetailModel(
      id: dto.malId,
      title: dto.titleEnglish ?? dto.title,
      imageUrl: dto.imageUrl,
      score: dto.score,
      year: dto.year ?? 0,
      genres: dto.genres,
      studio: dto.studio,
      synopsis: dto.synopsis,
      trailerUrl: dto.trailerUrl,
    );
  }

  AnimeModel _fromResponse(AnimeListModel anime) {
    return AnimeModel(
      id: anime.malId,
      title: anime.titleEnglish ?? anime.title,
      imageUrl: anime.image,
      score: anime.score,
      type: anime.type,
      subtitle:
          anime.aired?.string ??
          (anime.episodes != null ? '${anime.episodes} eps' : null),
    );
  }
}
