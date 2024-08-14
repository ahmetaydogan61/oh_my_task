import 'package:oh_my_task/main/ui/Tasks/TaskListActionButton.dart';

class TaskListAction {
  final TaskListActionButton? primaryActionButton;
  final TaskListActionButton? secondaryActionButton;
  final TaskListActionButton? otherAction;

  List<TaskListActionButton?> get allButtons =>
      [primaryActionButton, secondaryActionButton, otherAction];

  TaskListAction({
    required this.primaryActionButton,
    required this.secondaryActionButton,
    required this.otherAction,
  });
}
