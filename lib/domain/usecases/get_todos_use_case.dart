import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodosUseCase {
  final TodoRepository todoRepository;

  GetTodosUseCase(this.todoRepository);

  // fetch all todos
  Future<List<Todo>> execute() async {
    return await todoRepository.fetchAllTodos();
  }
}
