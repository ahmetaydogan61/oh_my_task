import 'package:oh_my_task/main/domain/task/api/TaskCategory.dart';
import 'package:oh_my_task/main/domain/task/api/TaskItem.dart';

abstract class TaskRepository {
  Stream<List<TaskItem>> get tasksStream;

  Future<void> addTask(TaskItem task);
  Future<void> removeTask(TaskItem task);

  Future<void> updateTaskCategory(TaskItem item, TaskCategory newCategory);
  Future<void> updateTaskTitle(TaskItem item, String newTitle);
  Future<void> updateTaskDescription(TaskItem item, String newDescription);

  Future<void> updateList(List<TaskItem> tasks);
  Future<void> saveTasks(List<TaskItem> tasks);
}
