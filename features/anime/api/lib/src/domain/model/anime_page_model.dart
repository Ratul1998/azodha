import 'package:anime_api/src/domain/model/anime_model.dart';

class AnimePageModel {
  final int pageNumber;
  final int totalItems;
  final List<AnimeModel> searchResult;

  const AnimePageModel({
    this.pageNumber = 1,
    this.totalItems = 0,
    this.searchResult = const [],
  });

  AnimePageModel copyWidth({
    int? pageNumber,
    int? totalItems,
    List<AnimeModel>? searchResult,
  }) => AnimePageModel(
    searchResult: searchResult ?? this.searchResult,
    totalItems: totalItems ?? this.totalItems,
    pageNumber: pageNumber ?? this.pageNumber,
  );
}
