import 'package:bluetooth_poc/todo.dart';
import 'package:bluetooth_poc/todo_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TodoProviderWidget(),
    );
  }
}

class TodoProviderWidget extends ConsumerWidget {
  const TodoProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todoNotifierProvider);
    return Scaffold(
      body: todos.maybeWhen(
          loading: () => const CircularProgressIndicator(),
          data: (data) => ListView.builder(
            itemCount: data.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(data[index].description),
                ),
              ),
          error: (object, stackTrace) => Text(stackTrace.toString()),
          orElse: () {
            return null;
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ref
              .read(todoNotifierProvider.notifier)
              .addTodo(Todo(description: "this is new todo: ${DateTime.timestamp().toIso8601String()}"));
        },
      ),
    );
  }
}
