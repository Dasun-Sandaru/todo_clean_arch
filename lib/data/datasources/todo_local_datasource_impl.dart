import '../../core/errors/exceptions.dart';
import '../models/todo_model.dart';
import 'todo_datasource.dart';

class TodoLocalDatasourceImpl extends TodoDataSource {
  // In-memory simulated database
  final List<TodoModel> _simulatedDatabase = [];

  @override
  Future<List<TodoModel>> fetchTodos() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_simulatedDatabase);
  }

  @override
  Future<TodoModel> fetchTodoById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final todo = _simulatedDatabase.firstWhere((todoId) => todoId.id == id);
    return todo;
  }

  @override
  Future<TodoModel> addTodo(TodoModel todoModel) async {
    await Future.delayed(const Duration(milliseconds: 300));

    final newId = todoModel.id.isEmpty
        ? DateTime.now().millisecondsSinceEpoch.toString()
        : todoModel.id;

    final createModel = TodoModel(
      id: newId,
      title: todoModel.title,
      description: todoModel.description,
      status: todoModel.status,
      createdAt: todoModel.createdAt,
    );

    _simulatedDatabase.add(createModel);
    return createModel;
  }

  @override
  Future<TodoModel> updateTodo(TodoModel todoModel) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _simulatedDatabase.indexWhere(
      (item) => item.id == todoModel.id,
    );

    if (index == -1) {
      throw CacheException("Todo item not found in local storage.");
    }

    _simulatedDatabase[index] = todoModel;
    return todoModel;
  }

  @override
  Future<void> deleteTodo(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _simulatedDatabase.indexWhere((item) => item.id == id);

    if (index == -1) {
      throw CacheException("Cannot delete: Todo item not found.");
    }

    _simulatedDatabase.removeAt(index);
  }
}
