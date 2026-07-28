import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository todoRepository;
  UpdateTodoUseCase(this.todoRepository);

  // update todo
  Future<Todo> execute({
    required Todo existingTodo,
    required String newTitle,
    required String newDescription,
  }) async {
    final updatedTodo = existingTodo.updateDetails(
      newTitle: newTitle,
      newDescription: newDescription,
    );
    return await todoRepository.updateTodo(updatedTodo);
  }
}
