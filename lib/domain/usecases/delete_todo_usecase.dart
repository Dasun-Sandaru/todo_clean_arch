import '../repositories/todo_repository.dart';

class DeleteTodoUsecase {
  final TodoRepository todoRepository;
  DeleteTodoUsecase(this.todoRepository);

  // delete todo
  Future<void> execute(String id) async {
    if (id.trim().isEmpty) {
      throw Exception("Todo Id cannot be empty");
    }
    await todoRepository.deleteTodo(id);
  }
}
