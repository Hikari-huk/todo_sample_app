import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskTile extends StatelessWidget {
  final bool isChecked;
  final String taskTitle;
  final String createdAt;
  final Function(bool?) checkboxCallback;
  final Function(DismissDirection) deleteCallback;

  TaskTile({
    required this.taskTitle,
    required this.isChecked,
    required this.createdAt,
    required this.checkboxCallback,
    required this.deleteCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(taskTitle),
      onDismissed: deleteCallback,
      background: Container(
        color: Colors.red,
        child: const Align(
          alignment: Alignment(0.8, 0.0),
          child: Icon(Icons.delete),
        ),
      ),
      child: ListTile(
          title: Column(
            children: [
              Text(
                taskTitle,
                style: TextStyle(
                    decoration: isChecked ? TextDecoration.lineThrough : null),
              ),
              Text(
                DateFormat('yyyy/MM/dd HH:mm').format(
                  DateTime.parse(createdAt),
                ),
                style: TextStyle(
                    decoration: isChecked ? TextDecoration.lineThrough : null),
              )
            ],
          ),
          trailing: Checkbox(
            activeColor: Colors.lightBlueAccent,
            value: isChecked,
            onChanged: checkboxCallback,
          )),
    );
  }
}
