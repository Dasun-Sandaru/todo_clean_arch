import '../../core/errors/exceptions.dart';

enum TodoStatus { pending, inProgress, completed }

class Todo {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final TodoStatus status;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.status = TodoStatus.pending,
  }) {
    // business rule Vvalidation: title cannot be empty
    if (title.trim().isEmpty) {
      throw DomainException("Todo Title cannot be empty");
    }
  }

  // toggle status and returns a new Todo object with the updated status
  Todo toggleStatus() {
    final newStatus = status == TodoStatus.pending
        ? TodoStatus.completed
        : TodoStatus.pending;

    return copyWith(status: newStatus);
  }

  // validate business rules and returns a new Todo object with the updated values
  Todo updateDetails({
    required String newTitle,
    required String newDescription,
  }) {
    if (newTitle.trim().isEmpty) {
      throw DomainException("Todo Title cannot be empty");
    }

    if (status == TodoStatus.completed) {
      throw DomainException("Completed Todos cannot be updated");
    }

    return copyWith(title: newTitle, description: newDescription);
  }

  /// helper method to clone object with modified properties
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    TodoStatus? status,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      status: status ?? this.status,
    );
  }
}
