import 'package:hive/hive.dart';
import 'package:todo_api/api.dart';

class TodoLocalDataSource {
  static const _boxName = 'todos_box';
  static const _keyName = 'todos';

  Future<Box> _openBox() async {
    return Hive.openBox(_boxName);
  }

  Future<void> saveTodos(List<TodoDetail> todos) async {
    final box = await _openBox();
    await box.put(_keyName, todos.map((e) => e.toJson()).toList());
  }

  Future<List<TodoDetail>> getTodos() async {
    final box = await _openBox();
    final data = box.get(_keyName);

    if (data == null) return [];

    return (data as List)
        .map((e) => TodoDetail.fromJson(Map<String, dynamic>.from(e)))
        .toList();
  }

  Future<void> clear() async {
    final box = await _openBox();
    await box.clear();
  }
}
