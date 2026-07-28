import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class ToggleTodoStatusUseCase {
  final TodoRepository todoRepository;
  ToggleTodoStatusUseCase(this.todoRepository);

  // toggle todo status
  Future<Todo> execute(Todo todo) async {
    final updatedTodo = todo.toggleStatus();
    return await todoRepository.updateTodo(updatedTodo);
  }
}
