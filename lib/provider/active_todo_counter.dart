import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_provider/provider/todo_list.dart';

class ActiveTodoCounterState extends Equatable {
  final int activeTodoCount;

  const ActiveTodoCounterState({required this.activeTodoCount});

  factory ActiveTodoCounterState.initial() =>
      const ActiveTodoCounterState(activeTodoCount: 0);

  @override
  List<Object> get props => [activeTodoCount];

  @override
  bool get stringify => true;

  ActiveTodoCounterState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCounterState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}

class TodoSearch with ChangeNotifier {
  ActiveTodoCounterState _state = ActiveTodoCounterState.initial();

  ActiveTodoCounterState get state => _state;

  void update(TodoList todoList) {
    final int newActiveTodoCount =
        todoList.state.todos.where((todo) => !todo.completed).toList().length;

    _state = _state.copyWith(activeTodoCount: newActiveTodoCount);
    notifyListeners();
  }
}
