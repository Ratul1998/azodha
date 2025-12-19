import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:todo_api/api.dart';
import 'package:dio/dio.dart';
import 'package:todo_impl/src/data_source/model/to_do_response_model.dart';

class ToDoService {
  static const baseUrl = 'https://jsonplaceholder.typicode.com';

  static const todoEndPoint = '/todos';

  final _dio = Dio(BaseOptions(baseUrl: baseUrl))
    ..interceptors.add(PrettyDioLogger());

  Future<void> addTodo(AddToDoModel todo) => _dio.post(
    todoEndPoint,
    data: ToDoResponseModel(
      userId: 1,
      id: 0,
      title: todo.title,
      completed: false,
    ).toJson(),
  );

  Future<void> completeTodo(int todoId) =>
      _dio.patch('$todoEndPoint/$todoId', data: {'completed': true});

  Future<void> deleteTodoModel(int id) => _dio.delete('$todoEndPoint/$id');

  Future<List<ToDoResponseModel>> getTodos() async {
    final response = await _dio.get(todoEndPoint);

    final todos = response.data as List<dynamic>;

    return todos.map((todo) => ToDoResponseModel.fromJson(todo)).toList();
  }
}
