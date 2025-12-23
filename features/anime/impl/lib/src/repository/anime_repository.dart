import 'package:anime_api/api.dart';
import 'package:anime_impl/src/repository/anime_mapper.dart';
import 'package:anime_impl/src/service/anime_service.dart';
import 'package:anime_impl/src/service/data/anime_search_request_model.dart';

class AnimeRepository {
  final AnimeService _service;
  final AnimeMapper _mapper;

  const AnimeRepository({
    required AnimeService service,
    required AnimeMapper mapper,
  }) : _mapper = mapper,
       _service = service;

  Future<List<AnimeModel>> getTrendingAnime() async {
    final request = _mapper.mapRequest(status: AnimeStatus.airing, limit: 7);

    final dto = await _service.searchAnime(request);

    return _mapper.mapDto(dto).searchResult;
  }

  Future<List<AnimeModel>> getUpcomingAnime() async {
    final request = _mapper.mapRequest(status: AnimeStatus.upcoming, limit: 7);

    final dto = await _service.searchAnime(request);

    return _mapper.mapDto(dto).searchResult;
  }

  Future<AnimePageModel> searchAnime({
    int page = 1,
    int limit = 15,
    String query = '',
    bool newReleases = false,
  }) async {
    final request = _mapper.mapRequest(
      status: newReleases ? AnimeStatus.upcoming : null,
      limit: limit,
      query: query,
      page: page,
    );

    final dto = await _service.searchAnime(request);

    return _mapper.mapDto(dto);
  }

  Future<AnimeDetailModel> getAnimeDetailById(int id) async {
    final dto = await _service.getAnimeDetailById(id);

    return _mapper.fromDto(dto);
  }
}
