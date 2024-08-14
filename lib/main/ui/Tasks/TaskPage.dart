import 'package:flutter/material.dart';
import 'package:oh_my_task/main/domain/task/api/TaskCategory.dart';
import 'package:oh_my_task/main/domain/task/api/TaskItem.dart';
import 'package:oh_my_task/main/ui/Tasks/TaskList.dart';
import 'package:oh_my_task/main/ui/Tasks/TaskPageViewModel.dart';
import 'package:oh_my_task/res/values/strings.dart';
import 'package:provider/provider.dart';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  TaskPageState createState() => TaskPageState();
}

class TaskPageState extends State<TaskPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.index = 1;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Future<void> _showAddItemDialog(
    Future<void> Function(TaskItem) onSubmit,
  ) async {
    final TextEditingController titleController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();

    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add New Item'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description (optional)',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  style: const TextStyle(color: Colors.black),
                  cursorColor: Colors.black,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    if (titleController.text.isNotEmpty) {
                      await onSubmit(
                        TaskItem(
                          title: titleController.text,
                          description: descriptionController.text,
                          category: TaskCategory.active,
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(appName),
        backgroundColor: Colors.blue,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.black,
          dividerColor: Colors.white,
          indicatorColor: Colors.white,
          tabs: const [
            Tab(icon: Icon(Icons.archive), text: 'Archive'),
            Tab(icon: Icon(Icons.list), text: 'Active'),
            Tab(icon: Icon(Icons.done), text: 'Done'),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Consumer<TaskPageViewModel>(
          builder: (context, viewModel, child) {
            var tasks = viewModel.tasks;
            return TabBarView(
              controller: _tabController,
              children: [
                //Archived List
                TaskList(
                  onTitleChange: (task, title) =>
                      viewModel.updateTaskTitle(task, title),
                  onDescriptionChange: (task, title) =>
                      viewModel.updateTaskDescription(task, title),
                  tasks: tasks(TaskCategory.archived),
                  taskListAction: viewModel.archiveAction,
                ),
                //Active List
                TaskList(
                  onTitleChange: (task, title) =>
                      viewModel.updateTaskTitle(task, title),
                  onDescriptionChange: (task, title) =>
                      viewModel.updateTaskDescription(task, title),
                  tasks: tasks(TaskCategory.active),
                  taskListAction: viewModel.activeActions,
                ),
                //Done List
                TaskList(
                  onTitleChange: (task, title) =>
                      viewModel.updateTaskTitle(task, title),
                  onDescriptionChange: (task, title) =>
                      viewModel.updateTaskDescription(task, title),
                  tasks: tasks(TaskCategory.done),
                  taskListAction: viewModel.doneActions,
                ),
              ],
            );
          },
        ),
      ),
      backgroundColor: Colors.blueGrey,
      floatingActionButton: Consumer<TaskPageViewModel>(
        builder: (context, viewModel, child) {
          return FloatingActionButton(
            backgroundColor: Colors.lightBlue,
            child: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              await _showAddItemDialog((task) => viewModel.addItem(task));
            }, // onPressed
          );
        },
      ),
    );
  }
}
