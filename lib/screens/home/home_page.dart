import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/todo_controller.dart';
import 'package:todo_app/utils/constants.dart';
import 'package:todo_app/utils/reusable_widgets.dart';
import 'package:todo_app/utils/shimmers.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TodoController());

    return Obx(() => Scaffold(
          backgroundColor: ColorConstants.primaryColor,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // const SizedBox(height: 100),

                    reusableText(
                        StringConstants.todoList, robotoText(fontsize: 20)),
                    controller.isLoading.isTrue
                        ? Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: 5,
                              itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ShimmerWidgets().listSize(),
                              ),
                            ),
                          )
                        : controller.toDoList.isEmpty
                            ? Center(
                                child:
                                    reusableText('List is Empty', robotoText()),
                              )
                            : ListView.builder(
                                itemCount: controller.toDoList.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) => Dismissible(
                                  key: ValueKey(controller.toDoList[index]),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: customContainer(
                                        height: 70.sp,
                                        width: double.infinity,
                                        child: Padding(
                                          padding: const EdgeInsets.all(15.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                flex: 8,
                                                child: reusableText(
                                                    controller
                                                        .toDoList[index].title!,
                                                    robotoText().copyWith(
                                                        decoration: controller
                                                                    .toDoList[
                                                                        index]
                                                                    .isCompleted ==
                                                                true
                                                            ? TextDecoration
                                                                .lineThrough
                                                            : TextDecoration
                                                                .none,
                                                        decorationColor:
                                                            Colors.white)),
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: IconButton(
                                                    onPressed: controller
                                                                .toDoList[index]
                                                                .isCompleted ==
                                                            true
                                                        ? null
                                                        : () {
                                                            controller.todoComplete(
                                                                controller
                                                                    .toDoList[
                                                                        index]
                                                                    .id!,
                                                                controller
                                                                    .toDoList[
                                                                        index]
                                                                    .title!);
                                                          },
                                                    icon: Icon(Icons.done,
                                                        color: controller
                                                                    .toDoList[
                                                                        index]
                                                                    .isCompleted ==
                                                                true
                                                            ? Colors.greenAccent
                                                            : Colors.white,
                                                        size: 30)),
                                              )
                                            ],
                                          ),
                                        )),
                                  ),
                                ),
                              )
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.showDialogueBox();
            },
            backgroundColor: Colors.purpleAccent,
            shape: const CircleBorder(),
            child: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ));
  }
}
