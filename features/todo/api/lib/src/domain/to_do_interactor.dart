import 'package:todo_api/src/domain/model/add_to_do_model.dart';
import 'package:todo_api/src/domain/model/todo_detail.dart';

abstract class ToDoInteractor {
  Stream<List<TodoDetail>> getTodos();

  Future<void> addTodo(AddToDoModel todo);

  Future<void> completeTodo(int todoId);

  Future<void> deleteTodoModel(int id);

  void refreshTodos();
}
