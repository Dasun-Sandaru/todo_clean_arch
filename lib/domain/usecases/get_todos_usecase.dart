import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class GetTodosUsecase {
  final TodoRepository todoRepository;

  GetTodosUsecase(this.todoRepository);

  // fetch all todos
  Future<List<Todo>> execute() async {
    return await todoRepository.fetchAllTodos();
  }
}
