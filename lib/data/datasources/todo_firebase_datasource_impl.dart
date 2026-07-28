import '../../core/errors/exceptions.dart';
import '../models/todo_model.dart';
import 'todo_datasource.dart';

class TodoFirebaseDatasourceImpl implements TodoDataSource {
  // pass FirebaseFirestore.instance via constructor in actual usage
  // final FirebaseFirestore firestore;
  // TodoFirebaseDatasourceImpl(this.firestore);

  @override
  Future<List<TodoModel>> fetchTodos() async {
    try {
      // Simulation of Firestore collection fetch
      // final snapshot = await firestore.collection('todos').get();
      // return snapshot.docs.map((doc) => TodoModel.fromFirestore(doc.data(), doc.id)).toList();
      return [];
    } catch (e) {
      throw ServerException("Firestore fetch error: ${e.toString()}");
    }
  }

  @override
  Future<TodoModel> fetchTodoById(String id) async {
    try {
      // final snapshot = await firestore.collection('todos').doc(id).get();
      // return TodoModel.fromFirestore(snapshot.data()!, snapshot.id);
      return TodoModel(
        id: id,
        title: 'Test',
        description: '',
        createdAt: DateTime.now(),
      );
    } catch (e) {
      throw ServerException("Firestore fetch by id error: ${e.toString()}");
    }
  }

  @override
  Future<TodoModel> addTodo(TodoModel todoModel) async {
    try {
      // final docRef = await firestore.collection('todos').add(todoModel.toJson());
      // return todoModel.copyWith(id: docRef.id);
      return todoModel;
    } catch (e) {
      throw ServerException("Firestore add error: ${e.toString()}");
    }
  }

  @override
  Future<TodoModel> updateTodo(TodoModel todoModel) async {
    try {
      // await firestore.collection('todos').doc(todoModel.id).update(todoModel.toJson());
      return todoModel;
    } catch (e) {
      throw ServerException("Firestore update error: ${e.toString()}");
    }
  }

  @override
  Future<void> deleteTodo(String id) async {
    try {
      // await firestore.collection('todos').doc(id).delete();
      return;
    } catch (e) {
      throw ServerException("Firestore delete error: ${e.toString()}");
    }
  }
}
