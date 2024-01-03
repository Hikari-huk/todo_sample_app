import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:todo_sample_app/models/tasks_provider.dart';
import 'package:todo_sample_app/widgets/task_tile.dart';

class TasksList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskProvider>(
      builder: (context, taskData, child) {
        return ListView.builder(
          itemBuilder: (context, index) {
            final task = taskData.tasks[index];
            return TaskTile(
              taskTitle: task.name,
              isChecked: task.isDone,
              createdAt: task.createdAt,
              checkboxCallback: (bool? checkboxState) {
                taskData.updateTask(task);
              },
              deleteCallback: (DismissDirection direction) {
                taskData.deleteTask(task);
              },
            );
          },
          itemCount: taskData.taskCount,
        );
      },
    );
  }
}
