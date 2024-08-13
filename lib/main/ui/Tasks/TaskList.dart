import 'package:flutter/material.dart';
import 'package:oh_my_task/main/domain/task/api/TaskItem.dart';
import 'package:oh_my_task/main/ui/Tasks/TaskListActionButton.dart';

class TaskList extends StatelessWidget {
  final List<TaskItem> tasks;
  final List<TaskListActionButton> actionButtons;
  final Future<void> Function(TaskItem, String) onTitleChange;
  final Future<void> Function(TaskItem, String) onDescriptionChange;

  const TaskList({
    super.key,
    required this.tasks,
    required this.actionButtons,
    required this.onTitleChange,
    required this.onDescriptionChange,
  });

  Future<void> _showItemDetailsDialog(
    BuildContext context,
    TaskItem task,
  ) async {
    bool isEditingTitle = false;
    FocusNode titleFocusNode = FocusNode();
    TextEditingController titleEditingController =
        TextEditingController(text: task.title);

    bool isEditingDesc = false;
    FocusNode descFocusNode = FocusNode();
    TextEditingController descEditingController =
        TextEditingController(text: task.description);

    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                title: Row(
                  children: [
                    Expanded(
                      child: isEditingTitle
                          ? EditableText(
                              controller: titleEditingController,
                              focusNode: titleFocusNode,
                              maxLines: null,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                              cursorColor: Colors.black,
                              backgroundCursorColor: Colors.transparent,
                            )
                          : Text(
                              task.title,
                              maxLines: 1,
                              style: const TextStyle(
                                color: Colors.black,
                                overflow: TextOverflow.ellipsis,
                                fontSize: 18,
                              ),
                            ),
                    ),
                    IconButton(
                      focusColor: Colors.transparent,
                      color: Colors.transparent,
                      hoverColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      disabledColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () async => {
                        setState(
                          () {
                            if (isEditingTitle) {
                              isEditingTitle = false;
                              titleFocusNode.unfocus();
                            } else {
                              isEditingTitle = true;
                              titleFocusNode.requestFocus();
                            }
                          },
                        ),
                        if (titleEditingController.text.isNotEmpty)
                          await onTitleChange(task, titleEditingController.text)
                      },
                      icon: isEditingTitle
                          ? const Icon(Icons.done, color: Colors.black)
                          : const Icon(Icons.edit, color: Colors.black),
                    ),
                  ],
                ),
                backgroundColor: Colors.white,
                content: SingleChildScrollView(
                  child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.all(Radius.circular(8.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          padding: task.description.isNotEmpty || isEditingDesc
                              ? const EdgeInsets.all(12.0)
                              : const EdgeInsets.all(0.0),
                          child: isEditingDesc
                              ? EditableText(
                                  controller: descEditingController,
                                  focusNode: descFocusNode,
                                  maxLines: null,
                                  style: const TextStyle(color: Colors.black),
                                  cursorColor: Colors.black,
                                  backgroundCursorColor: Colors.transparent,
                                )
                              : task.description.isNotEmpty
                                  ? Text(task.description)
                                  : Container(),
                        ),
                        IconButton(
                          focusColor: Colors.transparent,
                          color: Colors.transparent,
                          hoverColor: Colors.transparent,
                          splashColor: Colors.transparent,
                          disabledColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onPressed: () async => {
                            setState(
                              () {
                                if (isEditingDesc) {
                                  isEditingDesc = false;
                                  descFocusNode.unfocus();
                                } else {
                                  isEditingDesc = true;
                                  descFocusNode.requestFocus();
                                }
                              },
                            ),
                            await onDescriptionChange(
                                task, descEditingController.text)
                          },
                          icon: isEditingDesc
                              ? const Icon(Icons.done, color: Colors.black)
                              : const Icon(Icons.edit, color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: actionButtons.map(
                          (button) {
                            return IconButton(
                              style: button.style,
                              icon: button.icon,
                              onPressed: () async {
                                Navigator.of(context).pop();
                                await button.action(task);
                              },
                            );
                          },
                        ).toList(),
                      ),
                      TextButton(
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.lightBlue,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text("OK"),
                      ),
                    ],
                  )
                ],
              );
            },
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 8.0,
            color: Colors.white,
            margin: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 6.0),
            child: ListTile(
              title: Text(tasks[index].title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: Colors.black)),
              onTap: () async =>
                  await _showItemDetailsDialog(context, tasks[index]),
            ),
          );
        });
  }
}
