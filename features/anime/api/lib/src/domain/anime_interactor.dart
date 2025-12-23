import 'package:anime_api/api.dart';

abstract class AnimeInteractor {
  Future<List<AnimeModel>> getTrendingAnime();

  Future<List<AnimeModel>> getUpcomingAnime();

  Future<AnimePageModel> searchAnime({
    int page = 1,
    int limit = 15,
    String query = '',
    bool newReleases = false,
  });

  Future<AnimeDetailModel> getAnimeDetailById(int id);
}
