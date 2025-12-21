import 'package:todo_api/api.dart';
import 'package:todo_impl/src/data_source/to_do_local_data_source.dart';
import 'package:todo_impl/src/data_source/to_do_service.dart';
import 'package:todo_impl/src/repository/connectivity_service.dart';
import 'package:todo_impl/src/repository/todo_mapper.dart';

class ToDoRepository {
  final TodoMapper _mapper;
  final ToDoService _service;
  final ConnectivityService _connectivityService;
  final TodoLocalDataSource _localDataSource;

  ToDoRepository({
    required TodoMapper mapper,
    required ToDoService service,
    required ConnectivityService connectionService,
    required TodoLocalDataSource localSource,
  }) : _service = service,
       _mapper = mapper,
       _connectivityService = connectionService,
       _localDataSource = localSource {
    _listenToConnectivity();
  }

  Stream<List<TodoDetail>> get todoStream => _localDataSource.listenTodos();

  void _listenToConnectivity() {
    _connectivityService.connectivityStream.listen((isConnected) {
      if (isConnected) {
        syncTodos();
      }
    });
  }

  Future<void> syncTodos() async {
    final dto = await _service.getTodos();
    final todos = _mapper.mapTodoResponse(dto);

    await _localDataSource.saveTodos(todos);
  }

  Future<void> addTodo(AddToDoModel todo) => _localDataSource.addTodo(todo);

  Future<void> completeTodo(int todoId) =>
      _localDataSource.completeTodo(todoId);

  Future<void> deleteTodoModel(int id) => _localDataSource.deleteTodoModel(id);
}
