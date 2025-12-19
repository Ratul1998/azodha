import 'package:get_it/get_it.dart';
import 'package:todo_api/api.dart';
import 'package:todo_ui/src/screen/cubit/to_do_cubit.dart';

abstract class ToDoModuleDependencyProvider {
  static void register() {
    final di = GetIt.instance;

    di.registerFactory(() => TodoCubit(interactor: di.get<ToDoInteractor>()));
  }
}
