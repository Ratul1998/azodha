import 'package:hive/hive.dart';
import 'package:todo_api/api.dart';

class TodoLocalDataSource {
  static const _todoBox = 'todos_box';
  static const _auditBox = 'audits';

  bool _initialized = false;

  Future<Box> _openBox(String name) async {
    return Hive.openBox(name);
  }

  Future<void> saveTodos(List<TodoDetail> todos) async {
    final box = await _openBox(_todoBox);
    final auditBox = await _openBox(_auditBox);

    final newTodos = todos
        .where(
          (todo) =>
              !box.containsKey(todo.id.toString()) &&
              !auditBox.containsKey(todo.id.toString()),
        )
        .toList();

    await box.putAll(
      Map.fromEntries(
        newTodos.map((e) => MapEntry(e.id.toString(), e.toJson())),
      ),
    );
  }

  Future<List<TodoDetail>> getTodos() async {
    final box = await _openBox(_todoBox);
    final data = box.values.toList();

    return data.map((e) => TodoDetail.fromJson(Map.from(e))).toList();
  }

  Stream<List<TodoDetail>> listenTodos() async* {
    final box = await _openBox(_todoBox);

    if (!_initialized) {
      _initialized = true;
      yield* getTodos().asStream();
    }

    yield* box.watch().map(
      (event) =>
          box.values.map((e) => TodoDetail.fromJson(Map.from(e))).toList(),
    );
  }

  Future<void> addTodo(AddToDoModel todo) async {
    final id = DateTime.now().millisecondsSinceEpoch;
    final box = await _openBox(_todoBox);
    await box.put(
      id.toString(),
      TodoDetail(id: id, title: todo.title, completed: false).toJson(),
    );
  }

  Future<void> completeTodo(int todoId) async {
    final box = await _openBox(_todoBox);

    final todo = TodoDetail.fromJson(
      Map<String, dynamic>.from(box.get(todoId.toString())),
    );

    await box.put(
      todoId.toString(),
      todo.copyWith(completed: !todo.completed).toJson(),
    );
  }

  Future<void> deleteTodoModel(int id) async {
    final box = await _openBox(_todoBox);

    final auditBox = await _openBox(_auditBox);

    await box.delete(id.toString());

    await auditBox.put(id.toString(), DateTime.now().millisecondsSinceEpoch);
  }
}
