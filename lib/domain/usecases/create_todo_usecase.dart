import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class CreateTodoUsecase {
  final TodoRepository todoRepository;
  CreateTodoUsecase(this.todoRepository);

  // create todo
  Future<Todo> execute({
    required String title,
    required String description,
  }) async {
    // instantiating the Todo entity triggers core domain validations
    final newTodo = Todo(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );

    return await todoRepository.createTodo(newTodo);
  }
}
