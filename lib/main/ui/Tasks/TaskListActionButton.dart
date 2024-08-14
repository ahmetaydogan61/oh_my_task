import 'package:flutter/material.dart';
import 'package:oh_my_task/main/domain/task/api/TaskItem.dart';

class TaskListActionButton {
  final Future<void> Function(TaskItem) action;
  final Icon icon;
  final Color color;
  final iconButtonStyle = IconButton.styleFrom(
    backgroundColor: Colors.lightBlue,
  );

  TaskListActionButton({
    required this.action,
    required this.icon,
    required this.color,
  });
}
