import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// String 값 하나로 너무 거하게 state를 관리한다고 생각할 수 있지만
/// 1. 모든 state를 다룰 때 일관성을 지킨다는 점. 즉, 예측이 가능한 코드를 만드는 목적
/// 2. 타입의 충돌을 피할 수 있음. 타입이 같으면 자기에게서 더 멀리 떨어진 object에는 access 할 수 없다는 점을 필할 수 있다.
class TodoSearchState extends Equatable {
  final String searchTerm;

  const TodoSearchState({required this.searchTerm});

  factory TodoSearchState.initial() => const TodoSearchState(searchTerm: '');

  @override
  List<Object> get props => [searchTerm];

  @override
  bool get stringify => true;

  TodoSearchState copyWith({
    String? searchTerm,
  }) {
    return TodoSearchState(
      searchTerm: searchTerm ?? this.searchTerm,
    );
  }
}

class TodoSearch with ChangeNotifier {
  TodoSearchState _state = TodoSearchState.initial();

  TodoSearchState get state => _state;

  void setSearchTerm(String newSearchTerm) {
    _state = _state.copyWith(searchTerm: newSearchTerm);
    notifyListeners();
  }
}
