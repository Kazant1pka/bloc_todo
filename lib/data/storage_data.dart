import 'package:todo/domain/todo.dart';

abstract class StorageData {
  const StorageData();

  Stream<List<Todo>> getTodos();

  Future<void> saveTodo(Todo todo);

  Future<void> deleteTodo(String id);

  Future<int> clearCompleted();

  Future<int> completeAll({required bool isCompleted});
}

class TodoNotFoundException implements Exception {}
