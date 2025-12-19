import 'package:todo_api/api.dart';

class TodoState {
  final List<TodoDetail> todos;
  final bool loading;
  final String? error;
  final String query;

  const TodoState({
    required this.todos,
    this.loading = false,
    this.error,
    this.query = '',
  });

  TodoState copyWith({
    List<TodoDetail>? todos,
    bool? loading,
    String? error,
    String? query,
  }) {
    return TodoState(
      todos: todos ?? this.todos,
      loading: loading ?? this.loading,
      error: error,
      query: query ?? this.query,
    );
  }

  List<TodoDetail> get filtered => todos
      .where((t) => t.title.toLowerCase().contains(query.toLowerCase()))
      .toList();
}
