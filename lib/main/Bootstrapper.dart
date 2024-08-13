import 'package:oh_my_task/main/domain/DomainBooter.dart';
import 'package:oh_my_task/main/ui/UiBooter.dart';

class Bootstrapper {
  Future<void> boot() async {
    await domainBoot();
    await uiBoot();
  }
}
