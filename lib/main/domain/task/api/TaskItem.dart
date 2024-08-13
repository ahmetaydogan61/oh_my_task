import 'package:oh_my_task/main/domain/task/api/TaskCategory.dart';

class TaskItem {
  String title;
  String description;
  TaskCategory category;

  TaskItem({
    required this.title,
    required this.description,
    required this.category,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'category': category.toString(),
      };

  factory TaskItem.fromJson(Map<String, dynamic> json) => TaskItem(
        title: json['title'],
        description: json['description'],
        category: TaskCategory.values
            .firstWhere((e) => e.toString() == json['category']),
      );
}
