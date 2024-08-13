import 'package:oh_my_task/main/ui/Tasks/TaskPageViewModel.dart';
import 'package:oh_my_task/util/deption/Deption.dart';

Future<void> uiBoot() async {
  singleton<TaskPageViewModel>(TaskPageViewModel(get()));
}
