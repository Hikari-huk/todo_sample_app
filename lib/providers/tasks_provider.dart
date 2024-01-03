import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_sample_app/models/task.dart';

class TaskProvider extends ChangeNotifier {
  final Database database;
  TaskProvider({required this.database}) {
    loadTasks();
  }

  List<Task> _tasks = [];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  int get taskCount => _tasks.length;

  // データベースからタスクをロードする
  Future<void> loadTasks() async {
    final List<Map<String, dynamic>> maps = await database.query('todos');
    _tasks = List.generate(maps.length, (index) {
      return Task(
        id: maps[index]['id'],
        name: maps[index]['name'],
        isDone: maps[index]['isDone'] == 1,
        createdAt: maps[index]['createdAt'],
      );
    });
    notifyListeners();
  }

  void addTask(String newTaskTitle) async {
    final task =
        Task(name: newTaskTitle, createdAt: DateTime.now().toIso8601String());
    await database.insert('todos', task.toMap());
    await loadTasks();
  }

  // タスクの状態を更新する
  Future<void> updateTask(Task task) async {
    task.toggleDone();
    await database.update(
      'todos',
      task.toMap(),
      where: 'id = ?',
      whereArgs: [task.id],
    );
    await loadTasks();
  }

  // タスクを削除する
  Future<void> deleteTask(Task task) async {
    await database.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [task.id],
    );
    await loadTasks();
  }
}
