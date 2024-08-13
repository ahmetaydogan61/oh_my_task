import 'package:flutter/material.dart';
import 'package:oh_my_task/main/ui/Tasks/TaskPage.dart';
import 'package:oh_my_task/main/ui/Tasks/TaskPageViewModel.dart';
import 'package:oh_my_task/util/deption/Deption.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ChangeNotifierProvider(
        create: (context) => getViewModel<TaskPageViewModel>(),
        child: const TaskPage(),
      ),
    );
  }
}
