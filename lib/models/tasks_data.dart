import 'dart:collection';

import 'package:flutter/foundation.dart';
import 'package:todo_sample_app/models/task.dart';

class TaskData extends ChangeNotifier {
  List<Task> _tasks = [Task(name: 'name')];

  UnmodifiableListView<Task> get tasks => UnmodifiableListView(_tasks);

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle) {
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }
}
