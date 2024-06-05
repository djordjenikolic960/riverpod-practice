import 'package:bluetooth_poc/todo.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'todo_notifier.g.dart';

@riverpod
class TodoNotifier extends _$TodoNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  @override
  Future<List<Todo>> build() async {
    _todos.addAll([
      Todo(description: 'Learn Flutter', completed: true),
      Todo(description: 'Learn Riverpod'),
    ]);
    return _todos;
  }

  Future<void> addTodo(Todo todo) async {
    await Future.delayed(const Duration(seconds: 2));
    _todos.add(todo);

    state = AsyncData(_todos);
  }
}

class Counter extends Notifier<int> {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state++;
  }
}
