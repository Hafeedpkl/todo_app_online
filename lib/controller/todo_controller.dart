import 'dart:developer';

import 'package:get/get.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/services/todo_service.dart';

class TodoController extends GetxController {
  RxList<TodoModel> toDoList = <TodoModel>[].obs;
  RxBool isLoading = false.obs;
  getTodo() async {
    isLoading(true);
    final response = await TodoService().getTodos();
    if (response != null) {
      toDoList((response as List).map((e) => TodoModel.fromJson(e)).toList());
    } else {
      log('response is null');
    }
    isLoading(false);
  }

  @override
  void onInit() {
    getTodo();
    super.onInit();
  }
}
