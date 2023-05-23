import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/todo_controller.dart';
import 'package:todo_app/model/todo_model.dart';
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
                        ? ListView.builder(
                            shrinkWrap: true,
                            itemCount: 15,
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ShimmerWidgets().listSize(),
                            ),
                          )
                        : controller.toDoList.isEmpty
                            ? Center(
                                child:
                                    reusableText('List is Empty', robotoText()),
                              )
                            : listSection(
                                controller, controller.toDoListnotDone),
                    listSection(controller, controller.toDoListDone)
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

  ListView listSection(TodoController controller, List<TodoModel> list) {
    return ListView.builder(
      itemCount: list.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Slidable(
          startActionPane: ActionPane(motion: const ScrollMotion(), children: [
            SlidableAction(
              onPressed: (context) {
                controller.deleteTodo(list[index].id!, list[index].title!);
              },
              backgroundColor: Colors.purpleAccent,
              icon: Icons.delete,
              label: 'delete',
            )
          ]),
          child: customContainer(
              height: 70.sp,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 8,
                      child: reusableText(
                          list[index].title!,
                          robotoText().copyWith(
                              decoration: list[index].isCompleted == true
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                              decorationColor: Colors.white,
                              color: list[index].isCompleted == true
                                  ? Colors.grey
                                  : Colors.white)),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconButton(
                          onPressed: list[index].isCompleted == true
                              ? null
                              : () {
                                  controller.todoComplete(
                                      list[index].id!, list[index].title!);
                                },
                          icon: Icon(Icons.done,
                              color: list[index].isCompleted == true
                                  ? Colors.transparent
                                  : Colors.white,
                              size: 30)),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
