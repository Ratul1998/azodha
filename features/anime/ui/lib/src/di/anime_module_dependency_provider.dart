import 'package:anime_api/api.dart';
import 'package:anime_ui/src/screen/detail_page/cubit/anime_detail_cubit.dart';
import 'package:anime_ui/src/screen/home_page/cubit/home_cubit.dart';
import 'package:get_it/get_it.dart';

abstract class AnimeModuleDependencyProvider {
  static void register() {
    final di = GetIt.instance;

    di.registerFactory<HomeCubit>(
      () => HomeCubit(interactor: di.get<AnimeInteractor>()),
    );

    di.registerFactoryParam<DetailCubit, int, void>(
      (id, _) => DetailCubit(interactor: di.get<AnimeInteractor>(), id: id),
    );
  }
}
