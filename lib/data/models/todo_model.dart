import '../../domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.createdAt,
    super.status,
  });

  // factory method to parse json payload from laravel api
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'] ?? '',
      status: TodoStatus.values.byName(json['status']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // factory method to parse document data from firebase firestore
  factory TodoModel.fromFirestore(Map<String, dynamic> json, String docId) {
    return TodoModel(
      id: docId,
      title: json['title'],
      description: json['description'] ?? '',
      status: TodoStatus.values.byName(json['status']),
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  // converts TodoModel instance to json map for reat api / firestore payloads
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.name,
      'created_at': createdAt.toIso8601String(),
    };
  }

  // helper factory to convert domain entity to Data Model
  factory TodoModel.fromEntity(Todo todo) {
    return TodoModel(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      status: todo.status,
      createdAt: todo.createdAt,
    );
  }
}
