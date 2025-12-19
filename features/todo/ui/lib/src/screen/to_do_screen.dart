import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_ui/src/screen/cubit/to_do_state.dart';

import 'cubit/to_do_cubit.dart';

class ToDoScreen extends StatelessWidget {
  const ToDoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final di = GetIt.instance;

    return BlocProvider(
      create: (context) => di.get<TodoCubit>()..loadTasks(),
      child: Builder(builder: (context) => _TodoWidget()),
    );
  }
}

class _TodoWidget extends StatelessWidget {
  const _TodoWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Todos')),
      body: BlocBuilder<TodoCubit, TodoState>(
        builder: (context, state) {
          final cubit = context.read<TodoCubit>();

          if (state.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.error != null) {
            return Center(child: Text(state.error!));
          }

          return ListView.builder(
            itemCount: state.todos.length,
            itemBuilder: (_, index) {
              final todo = state.todos[index];
              return _TodoTitleWidget(
                title: todo.title,
                completed: todo.completed,
                onChanged: (val) => cubit.toggleTask(todo),
                onDelete: () => cubit.deleteTask(todo.id),
              );
            },
          );
        },
      ),
    );
  }
}

class _TodoTitleWidget extends StatelessWidget {
  final String title;
  final bool completed;
  final ValueChanged<bool?>? onChanged;
  final VoidCallback? onDelete;

  const _TodoTitleWidget({
    required this.title,
    required this.completed,
    this.onChanged,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(value: completed, onChanged: onChanged),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              fontSize: 16,
              decoration: completed
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
              color: completed
                  ? Colors.grey
                  : Theme.of(context).textTheme.bodyLarge?.color,
            ),
          ),
        ),
        if (completed)
          IconButton(
            onPressed: onDelete,
            icon: Icon(Icons.delete),
            iconSize: 16,
            color: Colors.redAccent,
          ),
      ],
    );
  }
}
