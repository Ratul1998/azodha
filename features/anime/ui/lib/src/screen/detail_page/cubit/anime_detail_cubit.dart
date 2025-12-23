import 'package:anime_api/api.dart';
import 'package:anime_ui/src/screen/detail_page/cubit/anime_detail_state.dart';
import 'package:bloc/bloc.dart';

class DetailCubit extends Cubit<AnimeDetailState> {
  final AnimeInteractor _interactor;

  DetailCubit({required AnimeInteractor interactor, required int id})
    : _interactor = interactor,
      super(AnimeDetailsLoading(id));

  Future<void> load() async {
    try {
      final detail = await _interactor.getAnimeDetailById(state.id);
      emit(AnimeDetailsLoaded(state.id, detail: detail));
    } on Exception catch (e, str) {
      emit(AnimeDetailErrorState(state.id, error: e, trace: str));
    }
  }

  Future<List<AnimeModel>> getTrendingAnime() => _interactor.getTrendingAnime();
}
