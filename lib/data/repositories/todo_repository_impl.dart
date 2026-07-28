import 'package:todo_clean_arch/domain/entities/todo.dart';

import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_datasource.dart';
import '../models/todo_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoDataSource dataSource;

  TodoRepositoryImpl({required this.dataSource});

  @override
  Future<List<Todo>> fetchAllTodos() async {
    final models = await dataSource.fetchTodos();
    return models;
  }

  @override
  Future<Todo> fetchTodoById(String id) async {
    final model = await dataSource.fetchTodoById(id);
    return model;
  }

  @override
  Future<Todo> createTodo(Todo todo) async {
    final model = TodoModel.fromEntity(todo);
    return await dataSource.addTodo(model);
  }

  @override
  Future<void> deleteTodo(String id) async {
    await dataSource.deleteTodo(id);
  }

  @override
  Future<Todo> updateTodo(Todo todo) async {
    final model = TodoModel.fromEntity(todo);
    return await dataSource.updateTodo(model);
  }
}
