import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo/data/storage_data.dart';
import 'package:todo/domain/todo.dart';

class Storage extends StorageData {
  Storage({required SharedPreferences plugin}) : _plugin = plugin {
    _init();
  }

  final SharedPreferences _plugin;

  final _todoStreamController = BehaviorSubject<List<Todo>>.seeded(const []);

  /// The key used for storing the todos locally.
  ///
  /// This is only exposed for testing and shouldn't be used by consumers of
  /// this library.
  @visibleForTesting
  static const kTodosCollectionKey = '__todos_collection_key__';

  String? _getValue(String key) => _plugin.getString(key);
  Future<void> _setValue(String key, String value) =>
      _plugin.setString(key, value);

  void _init() {
    final todosJson = _getValue(kTodosCollectionKey);
    if (todosJson != null) {
      final todos = List<Map<dynamic, dynamic>>.from(
        json.decode(todosJson) as List,
      )
          .map((jsonMap) => Todo.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _todoStreamController.add(todos);
    } else {
      _todoStreamController.add(const []);
    }
  }

  @override
  Stream<List<Todo>> getTodos() => _todoStreamController.asBroadcastStream();

  @override
  Future<void> saveTodo(Todo todo) {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((element) => element.id == todo.id);
    if (todoIndex >= 0) {
      todos[todoIndex] = todo;
    } else {
      todos.add(todo);
    }
    _todoStreamController.add(todos);
    return _setValue(kTodosCollectionKey, json.encode(todos));
  }

  @override
  Future<void> deleteTodo(String id) {
    final todos = [..._todoStreamController.value];
    final todoIndex = todos.indexWhere((element) => element.id == id);
    if (todoIndex == -1) {
      throw TodoNotFoundException();
    } else {
      todos.removeAt(todoIndex);
      _todoStreamController.add(todos);
      return _setValue(kTodosCollectionKey, json.encode(todos));
    }
  }

  @override
  Future<int> clearCompleted() async {
    final todos = [..._todoStreamController.value];
    final completedTodosAmount =
        todos.where((element) => element.isCompleted).length;
    todos.removeWhere((element) => element.isCompleted);
    _todoStreamController.add(todos);
    await _setValue(kTodosCollectionKey, json.encode(todos));
    return completedTodosAmount;
  }

  @override
  Future<int> completeAll({required bool isCompleted}) async {
    final todos = [..._todoStreamController.value];
    final changedTodosAmount =
        todos.where((element) => element.isCompleted != isCompleted).length;
    final newTodos = [
      for (final todo in todos) todo.copyWith(isCompleted: isCompleted),
    ];
    _todoStreamController.add(newTodos);
    await _setValue(kTodosCollectionKey, json.encode(newTodos));
    return changedTodosAmount;
  }
}
