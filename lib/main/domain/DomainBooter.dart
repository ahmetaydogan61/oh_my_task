import 'package:oh_my_task/main/domain/task/api/TaskRepository.dart';
import 'package:oh_my_task/main/domain/task/platform/TaskRepositoryImpl.dart';
import 'package:oh_my_task/util/deption/Deption.dart';
import 'package:rx_shared_preferences/rx_shared_preferences.dart';

Future<void> domainBoot() async {
  final prefs = await SharedPreferences.getInstance();
  final rxPrefs = RxSharedPreferences(prefs);

  singleton(rxPrefs);

  singleton<TaskRepository>(TaskRepositoryImpl(get()));
}
