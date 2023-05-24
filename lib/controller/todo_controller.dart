import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/services/todo_service.dart';
import 'package:todo_app/utils/reusable_widgets.dart';

class TodoController extends GetxController {
  RxList<TodoModel> toDoList = <TodoModel>[].obs;
  RxList<TodoModel> toDoListDone = <TodoModel>[].obs;
  RxList<TodoModel> toDoListnotDone = <TodoModel>[].obs;
  TextEditingController textController = TextEditingController();
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();
  getTodo() async {
    isLoading(true);
    final response = await TodoService().getTodos();
    if (response != null) {
      toDoList((response as List).map((e) => TodoModel.fromJson(e)).toList());
      toDoListDone.clear();
      toDoListnotDone.clear();
      for (var element in toDoList) {
        if (element.isCompleted == true) {
          toDoListDone.add(element);
        } else {
          toDoListnotDone.add(element);
        }
      }
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
      final id = response['data']['insert_todos']['returning'][0]['id'];

      log(response.toString());
      toDoListnotDone.insert(
          0, TodoModel(title: textController.text, id: id, isCompleted: false));
    } else {
      log('controller is empty');
    }
    textController.clear();
  }

  todoComplete(int id, String title, int index) async {
    final response = await TodoService().todoComplete(id);
    if (response.statusCode == 200) {
      log(response.data.toString());
      toDoListnotDone.removeAt(index);
      toDoListDone.insert(
          0, TodoModel(title: title, id: id, isCompleted: true));
      Get.snackbar('Done', '$title is completed');
    } else {
      return null;
    }
  }

  deleteTodo(int id, String title, int index, bool isCompleted) async {
    final response = await TodoService().deleteTodos(id);
    if (response.statusCode == 200) {
      log(response.data.toString());
      isCompleted
          ? toDoListDone.removeAt(index)
          : toDoListnotDone.removeAt(index);
      Get.snackbar('Done', '$title is deleted Successfully');
    }
  }
}
