import 'package:todo_api/api.dart';
import 'package:todo_impl/src/repository/to_do_repository.dart';

class ToDoInteractorImpl implements ToDoInteractor {
  final ToDoRepository _repository;

  const ToDoInteractorImpl({required ToDoRepository repo}) : _repository = repo;

  @override
  Future<void> addTodo(AddToDoModel todo) => _repository.addTodo(todo);

  @override
  Future<void> completeTodo(int todoId) => _repository.completeTodo(todoId);

  @override
  Future<void> deleteTodoModel(int id) => _repository.deleteTodoModel(id);

  @override
  Stream<List<TodoDetail>> getTodos() => _repository.todoStream;

  @override
  void refreshTodos() => _repository.syncTodos();
}
