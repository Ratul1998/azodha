import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_api/api.dart';
import 'package:todo_ui/src/screen/cubit/to_do_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final ToDoInteractor _interactor;

  TodoCubit({required ToDoInteractor interactor})
    : _interactor = interactor,
      super(const TodoState(todos: []));

  Future<void> loadTasks() async {
    emit(state.copyWith(loading: true));

    _interactor.refreshTodos();

    _interactor.getTodos().listen(
      (todos) => emit(
        state.copyWith(
          todos: List.from(todos)..sort((a, b) => b.id.compareTo(a.id)),
          loading: false,
        ),
      ),
      onError: (error) =>
          emit(state.copyWith(error: error.toString(), loading: false)),
    );
  }

  void refresh() => _interactor.refreshTodos();

  Future<void> addTask(String title) async {
    final optimisticTodo = AddToDoModel(title: title);

    emit(state.copyWith(loading: true));

    try {
      await _interactor.addTodo(optimisticTodo);
    } on Exception catch (err, str) {
      debugPrintStack(stackTrace: str, label: err.toString());
    } finally {
      _interactor.refreshTodos();
    }
  }

  Future<void> toggleTask(TodoDetail todo) => _interactor.completeTodo(todo.id);

  Future<void> deleteTask(int id) => _interactor.deleteTodoModel(id);

  void search(String query) => emit(state.copyWith(query: query));
}
