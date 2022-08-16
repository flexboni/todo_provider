import 'package:equatable/equatable.dart';
import 'package:todo_provider/provider/todo_list.dart';

class ActiveTodoCountState extends Equatable {
  final int activeTodoCount;

  const ActiveTodoCountState({required this.activeTodoCount});

  factory ActiveTodoCountState.initial() =>
      const ActiveTodoCountState(activeTodoCount: 0);

  @override
  List<Object> get props => [activeTodoCount];

  @override
  bool get stringify => true;

  ActiveTodoCountState copyWith({
    int? activeTodoCount,
  }) {
    return ActiveTodoCountState(
      activeTodoCount: activeTodoCount ?? this.activeTodoCount,
    );
  }
}

class ActiveTodoCount {
  ActiveTodoCount({
    required this.todoList,
  });

  final TodoList todoList;

  ActiveTodoCountState get state => ActiveTodoCountState(
        activeTodoCount: todoList.state.todos
            .where((todo) => !todo.completed)
            .toList()
            .length,
      );
}
