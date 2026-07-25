import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class ToggleTodoStatusUsecase {
  final TodoRepository todoRepository;
  ToggleTodoStatusUsecase(this.todoRepository);

  // toggle todo status
  Future<Todo> execute(Todo todo) async {
    final updatedTodo = todo.toggleStatus();
    return await todoRepository.updateTodo(updatedTodo);
  }
}
