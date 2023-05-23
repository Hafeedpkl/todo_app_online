import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/utils/reusable_widgets.dart';

class TodoController extends GetxController {
  RxList<TodoModel> toDoList = <TodoModel>[].obs;
  TextEditingController textController = TextEditingController();
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
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

  showDialogueBox() {
    return Get.defaultDialog(
        title: 'Add Todo',
        titleStyle: robotoText().copyWith(color: Colors.black, fontSize: 25),
        content: Form(
            key: formKey,
            child: TextFormField(
              controller: textController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Enter Something';
                }
                return null;
              },
            )),
        confirm: ElevatedButton.icon(
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.purple)),
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: () {
            if (!formKey.currentState!.validate()) {
              log('controller is empty');
              return;
            } else {
              addTodo();
              log('dhldf');
              Get.back();
            }
          },
          label: reusableText('ADD', robotoText()),
        ));
  }

  addTodo() async {
    if (textController.text.isNotEmpty) {
      final response = await TodoService().addTodos(textController.text);
      log(response.toString());
      getTodo();
    } else {
      log('controller is empty');
    }
    textController.clear();
  }
}
