import 'package:get/get.dart';
import 'package:todo_app/controller/todo_controller.dart';

class HomePageBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(TodoController());
  }
}
