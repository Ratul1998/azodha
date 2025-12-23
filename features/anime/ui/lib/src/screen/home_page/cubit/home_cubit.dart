import 'package:anime_api/api.dart';
import 'package:anime_ui/src/screen/home_page/cubit/home_state.dart';
import 'package:anime_ui/src/utils/data.dart';
import 'package:bloc/bloc.dart';
import 'package:rxdart/rxdart.dart';

class HomeCubit extends Cubit<HomeState> {
  final AnimeInteractor _interactor;

  HomeCubit({required AnimeInteractor interactor})
    : _interactor = interactor,
      super(HomeState());

  void loadData() => Rx.merge([
    _interactor
        .getUpcomingAnime()
        .asStream()
        .map(Data.loaded)
        .startWith(Data.loading(state.upcoming.data ?? []))
        .onErrorReturnWith(
          (error, stackTrace) => Data.error(error: error, str: stackTrace),
        )
        .map((data) => state.copyWith(upcoming: data)),

    _interactor
        .getTrendingAnime()
        .asStream()
        .map(Data.loaded)
        .startWith(Data.loading(state.upcoming.data ?? []))
        .onErrorReturnWith(
          (error, stackTrace) => Data.error(error: error, str: stackTrace),
        )
        .map((data) => state.copyWith(trending: data)),
  ]).listen(emit);

  void onLoadNewReleases(int page) => _interactor
      .searchAnime(page: page, newReleases: true)
      .asStream()
      .map(
        (page) => Data.loaded(
          page.copyWidth(
            searchResult: [
              ...(state.newReleases.data?.searchResult ?? []),
              ...page.searchResult,
            ],
          ),
        ),
      )
      .startWith(
        Data.loading(state.newReleases.data?.copyWidth(pageNumber: page)),
      )
      .onErrorReturnWith(
        (error, stackTrace) => Data.error(error: error, str: stackTrace),
      )
      .map((data) => state.copyWith(newReleases: data))
      .listen(emit);

  void onSearchAnime({String query = '', int pageNumber = 1}) => _interactor
      .searchAnime(page: pageNumber, query: query)
      .asStream()
      .map(
        (page) => Data.loaded(
          page.pageNumber == 1
              ? page
              : page.copyWidth(
                  searchResult: [
                    ...(state.searchResults.data?.searchResult ?? []),
                    ...page.searchResult,
                  ],
                ),
        ),
      )
      .startWith(
        Data.loading(
          state.searchResults.data?.copyWidth(pageNumber: pageNumber),
        ),
      )
      .onErrorReturnWith(
        (error, stackTrace) => Data.error(error: error, str: stackTrace),
      )
      .map((data) => state.copyWith(searchResults: data))
      .listen(emit);
}
