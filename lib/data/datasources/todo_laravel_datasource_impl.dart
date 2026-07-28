import 'package:dio/dio.dart';
import 'package:todo_clean_arch/core/constants/api_constants.dart';

import '../../core/errors/exceptions.dart';
import '../../core/network/dio_client.dart';
import '../models/todo_model.dart';
import 'todo_datasource.dart';

class TodoLaravelDataSourceImpl implements TodoDataSource {
  final DioClient _dioClient;

  TodoLaravelDataSourceImpl(this._dioClient);

  @override
  Future<List<TodoModel>> fetchTodos() async {
    try {
      final response = await _dioClient.get(ApiConstants.todoPath);
      final List data = response.data['data'];
      return data.map((json) => TodoModel.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ServerException(
        e.message ?? "Failed to fetch todos from Laravel server.",
      );
    }
  }

  @override
  Future<TodoModel> fetchTodoById(String id) async {
    try {
      final response = await _dioClient.get(
        ApiConstants.todoPath,
        queryParameters: {'id': id},
      );
      return TodoModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw ServerException(
        e.message ?? "Failed to fetch todo from Laravel server.",
      );
    }
  }

  @override
  Future<TodoModel> addTodo(TodoModel todoModel) async {
    try {
      final response = await _dioClient.post(
        ApiConstants.todoPath,
        data: todoModel.toJson(),
      );
      return TodoModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw ServerException(
        e.message ?? "Failed to add todo to Laravel server.",
      );
    }
  }

  @override
  Future<TodoModel> updateTodo(TodoModel todoModel) async {
    try {
      final response = await _dioClient.put(
        ApiConstants.todoById(todoModel.id),
        data: todoModel.toJson(),
      );
      return TodoModel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw ServerException(
        e.message ?? "Failed to update todo on Laravel server.",
      );
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    try {
      await _dioClient.delete(ApiConstants.todoById(id));
    } on DioException catch (e) {
      throw ServerException(
        e.message ?? "Failed to delete todo on Laravel server.",
      );
    }
  }
}
