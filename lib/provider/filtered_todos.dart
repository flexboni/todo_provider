import 'package:equatable/equatable.dart';
import 'package:todo_provider/model/todo_model.dart';
import 'package:todo_provider/provider/todo_filter.dart';
import 'package:todo_provider/provider/todo_list.dart';
import 'package:todo_provider/provider/todo_search.dart';

class FilteredTodosState extends Equatable {
  final List<Todo> filteredTodos;

  const FilteredTodosState({required this.filteredTodos});

  factory FilteredTodosState.initial() =>
      const FilteredTodosState(filteredTodos: []);

  @override
  List<Object> get props => [filteredTodos];

  @override
  bool get stringify => true;

  FilteredTodosState copyWith({
    List<Todo>? filteredTodos,
  }) {
    return FilteredTodosState(
      filteredTodos: filteredTodos ?? this.filteredTodos,
    );
  }
}

class FilteredTodos {
  FilteredTodos({
    required this.todoFilter,
    required this.todoSearch,
    required this.todoList,
  });

  final TodoFilter todoFilter;
  final TodoSearch todoSearch;
  final TodoList todoList;

  FilteredTodosState get state {
    List<Todo> newFilteredTodos;

    switch (todoFilter.state.filter) {
      case Filter.active:
        newFilteredTodos =
            todoList.state.todos.where((todo) => !todo.completed).toList();
        break;
      case Filter.completed:
        newFilteredTodos =
            todoList.state.todos.where((todo) => todo.completed).toList();
        break;
      case Filter.all:
      default:
        newFilteredTodos = todoList.state.todos;
        break;
    }

    if (todoSearch.state.searchTerm.isNotEmpty) {
      newFilteredTodos = newFilteredTodos
          .where((todo) => todo.desc
              .toUpperCase()
              .contains(todoSearch.state.searchTerm.toUpperCase()))
          .toList();
    }

    return FilteredTodosState(filteredTodos: newFilteredTodos);
  }
}
