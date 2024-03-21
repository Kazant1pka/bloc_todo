import 'package:todo/domain/todo.dart';

enum TodosViewFilter { all, activeonly, completedOnle }

extension TodosViewFilterX on TodosViewFilter {
  bool apply(Todo todo) {
    switch (this) {
      case TodosViewFilter.all:
        return true;
      case TodosViewFilter.activeonly:
        return !todo.isCompleted;
      case TodosViewFilter.completedOnle:
        return todo.isCompleted;
    }
  }

  Iterable<Todo> applyAll(Iterable<Todo> todos) {
    return todos.where(apply);
  }
}
