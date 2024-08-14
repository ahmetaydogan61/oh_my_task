import 'package:flutter/material.dart';
import 'package:oh_my_task/main/domain/task/api/TaskCategory.dart';
import 'package:oh_my_task/main/domain/task/api/TaskItem.dart';
import 'package:oh_my_task/main/domain/task/api/TaskRepository.dart';
import 'package:oh_my_task/main/ui/Tasks/TaskListAction.dart';
import 'package:oh_my_task/main/ui/Tasks/TaskListActionButton.dart';
import 'package:rxdart/rxdart.dart';

extension on List<TaskItem> {
  List<TaskItem> filterToCategory(TaskCategory category) {
    return where((item) => item.category == category).toList();
  }
}

class TaskPageViewModel extends ChangeNotifier {
  final TaskRepository _taskRepository;
  final CompositeSubscription _disposables = CompositeSubscription();
  List<TaskItem> _tasks = List.empty();

  TaskPageViewModel(TaskRepository taskRepository)
      : _taskRepository = taskRepository {
    _taskRepository.tasksStream.listen(
      (data) {
        _tasks = data;
        notifyListeners();
      },
    ).addTo(_disposables);
  }

  List<TaskItem> tasks(TaskCategory category) =>
      _tasks.filterToCategory(category);

  Future<void> updateItem(TaskItem item, TaskCategory newCategory) async {
    await _taskRepository.updateTaskCategory(item, newCategory);
  }

  Future<void> addItem(TaskItem task) async {
    await _taskRepository.addTask(task);
  }

  Future<void> removeItem(TaskItem task) async {
    await _taskRepository.removeTask(task);
  }

  Future<void> updateTaskCategory(
    TaskItem task,
    TaskCategory taskCategory,
  ) async {
    await _taskRepository.updateTaskCategory(task, taskCategory);
  }

  Future<void> updateTaskTitle(
    TaskItem task,
    String title,
  ) async {
    await _taskRepository.updateTaskTitle(task, title);
  }

  Future<void> updateTaskDescription(
    TaskItem task,
    String description,
  ) async {
    await _taskRepository.updateTaskDescription(task, description);
  }

  void changeViewCategory(TaskCategory taskCategory) {
    notifyListeners();
  }

  TaskListActionButton get _deleteAction => TaskListActionButton(
        action: (TaskItem task) async {
          await removeItem(task);
        },
        icon: const Icon(Icons.delete, color: Colors.white),
        color: Colors.red,
      );

  TaskListActionButton get _doneAction => TaskListActionButton(
        action: (TaskItem task) async {
          await updateTaskCategory(task, TaskCategory.done);
        },
        icon: const Icon(Icons.done, color: Colors.white),
        color: Colors.green,
      );

  TaskListActionButton get _archiveAction => TaskListActionButton(
        action: (TaskItem task) async {
          await updateTaskCategory(task, TaskCategory.archived);
        },
        icon: const Icon(Icons.archive, color: Colors.white),
        color: Colors.black54,
      );

  TaskListActionButton get _restoreAction => TaskListActionButton(
        action: (TaskItem task) async {
          await updateTaskCategory(task, TaskCategory.active);
        },
        icon: const Icon(Icons.restart_alt, color: Colors.white),
        color: Colors.blue,
      );

  TaskListAction get archiveAction => TaskListAction(
        primaryActionButton: _restoreAction,
        secondaryActionButton: _deleteAction,
        otherAction: null,
      );

  TaskListAction get activeActions => TaskListAction(
        primaryActionButton: _doneAction,
        secondaryActionButton: _archiveAction,
        otherAction: _deleteAction,
      );

  TaskListAction get doneActions => TaskListAction(
        primaryActionButton: _deleteAction,
        secondaryActionButton: _restoreAction,
        otherAction: _archiveAction,
      );

  @override
  void dispose() {
    super.dispose();
    _disposables.clear();
  }
}
