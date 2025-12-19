import 'package:todo_api/api.dart';
import 'package:todo_impl/src/data_source/model/to_do_response_model.dart';

class TodoMapper {
  List<TodoDetail> mapTodoResponse(List<ToDoResponseModel> todos) => todos
      .map(
        (todo) => TodoDetail(
          id: todo.id,
          title: todo.title,
          completed: todo.completed,
        ),
      )
      .toList();
}
