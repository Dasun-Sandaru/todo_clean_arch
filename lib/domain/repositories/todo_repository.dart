import '../entities/todo.dart';

abstract class TodoRepository {
  // fetch all todos
  Future<List<Todo>> fetchAllTodos();
  // fetch todo by id
  Future<Todo> fetchTodoById(String id);
  // create todo
  Future<Todo> createTodo(Todo todo);
  // update todo
  Future<Todo> updateTodo(Todo todo);
  // delete todo
  Future<void> deleteTodo(String id);
}
