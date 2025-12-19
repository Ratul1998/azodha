import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todo_api/api.dart';
import 'package:todo_impl/src/data_source/to_do_local_data_source.dart';
import 'package:todo_impl/src/data_source/to_do_service.dart';
import 'package:todo_impl/src/domain/to_do_interactor.dart';
import 'package:todo_impl/src/repository/connectivity_service.dart';
import 'package:todo_impl/src/repository/to_do_repository.dart';
import 'package:todo_impl/src/repository/todo_mapper.dart';

abstract class ToDoDomainDependencyProvider {
  static Future<void> register() async {
    final di = GetIt.instance;

    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);

    di.registerLazySingleton<ToDoService>(() => ToDoService());

    di.registerLazySingleton<TodoMapper>(() => TodoMapper());

    di.registerLazySingleton<ConnectivityService>(() => ConnectivityService());

    di.registerLazySingleton<TodoLocalDataSource>(() => TodoLocalDataSource());

    di.registerLazySingleton<ToDoRepository>(
      () => ToDoRepository(
        mapper: di.get(),
        service: di.get(),
        connectionService: di.get(),
        localSource: di.get(),
      ),
    );

    di.registerLazySingleton<ToDoInteractor>(
      () => ToDoInteractorImpl(repo: di.get()),
    );
  }
}
