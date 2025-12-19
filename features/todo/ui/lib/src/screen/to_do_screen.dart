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

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SearchBar(
                  onChanged: cubit.search,
                  hintText: 'Search tasks',
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(4),
                    ),
                  ),
                  elevation: WidgetStatePropertyAll(0),
                ),
              ),
              Expanded(
                child: RefreshIndicator(
                  child: ListView.builder(
                    itemCount: state.filtered.length,
                    itemBuilder: (_, index) {
                      final todo = state.filtered[index];
                      return _TodoTitleWidget(
                        title: todo.title,
                        completed: todo.completed,
                        onChanged: (val) => cubit.toggleTask(todo),
                        onDelete: () => cubit.deleteTask(todo.id),
                      );
                    },
                  ),
                  onRefresh: () async => cubit.refresh(),
                ),
              ),
            ],
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
