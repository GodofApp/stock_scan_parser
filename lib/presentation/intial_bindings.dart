
import 'package:get/get.dart';
import 'package:stock_scan_parser/presentation/controllers/item_controller.dart';
class InitialBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(ItemController());
  }
}
