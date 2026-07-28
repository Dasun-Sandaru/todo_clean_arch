import '../models/todo_model.dart';

abstract class TodoDataSource {
  Future<List<TodoModel>> fetchTodos();
  Future<TodoModel> fetchTodoById(String id);
  Future<TodoModel> addTodo(TodoModel todoModel);
  Future<TodoModel> updateTodo(TodoModel todoModel);
  Future<void> deleteTodo(String id);
}
