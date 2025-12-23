import 'package:anime_api/api.dart';
import 'package:anime_impl/src/domian/anime_interactor.dart';
import 'package:anime_impl/src/repository/anime_mapper.dart';
import 'package:anime_impl/src/repository/anime_repository.dart';
import 'package:anime_impl/src/service/anime_service.dart';
import 'package:get_it/get_it.dart';

abstract class AnimeDomainDependencyProvider {
  static void register() {
    final di = GetIt.instance;

    di.registerLazySingleton(() => AnimeService());

    di.registerLazySingleton(() => AnimeMapper());
    di.registerLazySingleton(
      () => AnimeRepository(service: di.get(), mapper: di.get()),
    );

    di.registerLazySingleton<AnimeInteractor>(
      () => AnimeInteractorImpl(repo: di.get()),
    );
  }
}
