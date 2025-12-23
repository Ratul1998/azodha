import 'package:anime_api/api.dart';
import 'package:anime_ui/src/utils/data.dart';

class HomeState {
  final Data<List<AnimeModel>> trending;
  final Data<List<AnimeModel>> upcoming;
  final Data<AnimePageModel> newReleases;
  final Data<AnimePageModel> searchResults;

  const HomeState({
    this.trending = const Data(),
    this.upcoming = const Data(),
    this.newReleases = const Data(),
    this.searchResults = const Data(),
  });

  HomeState copyWith({
    Data<List<AnimeModel>>? trending,
    Data<List<AnimeModel>>? upcoming,
    Data<AnimePageModel>? newReleases,
    Data<AnimePageModel>? searchResults,
  }) => HomeState(
    newReleases: newReleases ?? this.newReleases,
    searchResults: searchResults ?? this.searchResults,
    trending: trending ?? this.trending,
    upcoming: upcoming ?? this.upcoming,
  );

  bool get hasMoreNewReleases =>
      (newReleases.data?.searchResult.length ?? 0) <
      (newReleases.data?.totalItems ?? 0);

  bool get hasMoreSearchResult =>
      (searchResults.data?.searchResult.length ?? 0) <
      (searchResults.data?.totalItems ?? 0);
}
