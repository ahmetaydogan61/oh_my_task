import 'dart:convert';

import 'package:oh_my_task/main/domain/task/api/TaskCategory.dart';
import 'package:oh_my_task/main/domain/task/api/TaskItem.dart';
import 'package:oh_my_task/main/domain/task/api/TaskRepository.dart';
import 'package:oh_my_task/res/values/keys.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';
import 'package:rxdart/subjects.dart';

class TaskRepositoryImpl extends TaskRepository {
  final RxSharedPreferences _prefs;
  final BehaviorSubject<List<TaskItem>> _tasksSubject =
      BehaviorSubject<List<TaskItem>>.seeded([]);

  TaskRepositoryImpl(this._prefs) {
    _initialize();
  }

  Future<void> _initialize() async {
    _prefs.getStringStream(keyTaskItemList).map((jsonString) {
      if (jsonString == null) {
        _tasksSubject.add(List.empty());
      } else {
        List<dynamic> jsonList = jsonDecode(jsonString);
        final tasks =
            jsonList.map((jsonItem) => TaskItem.fromJson(jsonItem)).toList();
        _tasksSubject.add(tasks);
      }
    }).first;

    //updateList(List.empty());
  }

  @override
  Stream<List<TaskItem>> get tasksStream => _tasksSubject.stream;

  @override
  Future<void> updateList(List<TaskItem> tasks) async {
    _tasksSubject.add(tasks);
    await saveTasks(_tasksSubject.value);
  }

  @override
  Future<void> addTask(TaskItem task) async {
    final list = List.of(_tasksSubject.value);
    list.add(task);
    await saveTasks(list);
  }

  @override
  Future<void> removeTask(TaskItem task) async {
    final list = List.of(_tasksSubject.value);
    list.remove(task);
    await saveTasks(list);
  }

  @override
  Future<void> updateTaskCategory(
    TaskItem item,
    TaskCategory newCategory,
  ) async {
    final list = List.of(_tasksSubject.value);
    final index = list.indexOf(item);
    item.category = newCategory;
    list[index] = item;
    await saveTasks(_tasksSubject.value);
  }

  @override
  Future<void> updateTaskTitle(
    TaskItem item,
    String newTitle,
  ) async {
    final list = List.of(_tasksSubject.value);
    final index = list.indexOf(item);
    item.title = newTitle;
    list[index] = item;
    await saveTasks(_tasksSubject.value);
  }

  @override
  Future<void> updateTaskDescription(
    TaskItem item,
    String newDescription,
  ) async {
    final list = List.of(_tasksSubject.value);
    final index = list.indexOf(item);
    item.description = newDescription;
    list[index] = item;
    await saveTasks(_tasksSubject.value);
  }

  @override
  Future<void> saveTasks(List<TaskItem> tasks) async {
    final jsonList = tasks.map((task) => task.toJson()).toList();
    final jsonString = jsonEncode(jsonList);
    await _prefs.setString(keyTaskItemList, jsonString);
    _tasksSubject.add(tasks);
  }
}
