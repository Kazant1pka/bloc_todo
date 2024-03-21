import 'package:todo/data/storage_data.dart';
import 'package:todo/domain/todo.dart';

class StorageRepository {
  const StorageRepository({
    required StorageData storageData,
  }) : _storageData = storageData;

  final StorageData _storageData;

  Stream<List<Todo>> getTodos() => _storageData.getTodos();

  Future<void> saveTodo(Todo todo) => _storageData.saveTodo(todo);

  Future<void> deleteTodo(String id) => _storageData.deleteTodo(id);

  Future<int> clearCompleted() => _storageData.clearCompleted();

  Future<int> completeAll({required bool isCompleted}) =>
      _storageData.completeAll(isCompleted: isCompleted);
}
