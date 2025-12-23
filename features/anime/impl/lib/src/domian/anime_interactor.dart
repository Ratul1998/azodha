import 'package:anime_api/api.dart';
import 'package:anime_impl/src/repository/anime_repository.dart';

class AnimeInteractorImpl implements AnimeInteractor {
  final AnimeRepository _repository;

  const AnimeInteractorImpl({required AnimeRepository repo})
    : _repository = repo;

  @override
  Future<List<AnimeModel>> getTrendingAnime() => _repository.getTrendingAnime();

  @override
  Future<List<AnimeModel>> getUpcomingAnime() => _repository.getUpcomingAnime();

  @override
  Future<AnimePageModel> searchAnime({
    int page = 1,
    int limit = 15,
    String query = '',
    bool newReleases = false,
  }) => _repository.searchAnime(
    limit: limit,
    page: page,
    query: query,
    newReleases: newReleases,
  );

  @override
  Future<AnimeDetailModel> getAnimeDetailById(int id) =>
      _repository.getAnimeDetailById(id);
}
