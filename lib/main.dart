import 'package:flutter/material.dart';
import 'package:oh_my_task/main/Bootstrapper.dart';
import 'package:oh_my_task/main/ui/MainPage.dart';
import 'package:oh_my_task/main/ui/Tasks/TaskPageViewModel.dart';
import 'package:oh_my_task/util/deption/Deption.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Bootstrapper bootstrapper = Bootstrapper();
  await bootstrapper.boot();

  runApp(
    ChangeNotifierProvider(
      create: (context) => getViewModel<TaskPageViewModel>(),
      child: const MaterialApp(
        home: MainPage(),
      ),
    ),
  );
}
