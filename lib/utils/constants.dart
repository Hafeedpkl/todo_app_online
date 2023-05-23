import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/screens/home/home_page.dart';

class StringConstants {
  static const String homePage = '/homepage';
  static const String todoList = 'TODO LIST';
}

class ApiConstants {
  static const String baseUrl = 'https://trusted-dog-33.hasura.app/v1/graphql';
}

class Routes {
  static List<GetPage> getPageList = [
    GetPage(
      name: StringConstants.homePage,
      page: () => const HomePage(),
    )
  ];
}

class ColorConstants {
  static MaterialColor primarySwatch = Colors.purple;
  static Color primaryColor = const Color(0xFF303F9F);
  static const Color containerColor = Color.fromARGB(255, 8, 3, 73);
}

class Queries {
  static const getTodo = '''
query getTodo {
  todos {
    id
    title
    is_completed
  }
}

''';
  static const addTodo = '''
mutation addTodo(\$title: String!) {
  insert_todos(objects: {title: \$title,user_id:"1"}) {
    affected_rows
    returning {
      title
      user_id
      
    }
  }
}
''';
  static const update = '''
mutation update(\$id: Int!) {
  update_todos(where: {id: {_eq: \$id}}, _set: {is_completed: true}){
affected_rows
    returning{
      title
      created_at
      id
      is_completed
    }
  }
}
''';
  static const deleteTodo = '''
mutation deleteTask(\$id: Int!) {
  delete_todos(where: {id: {_eq: \$id}}){
    affected_rows
    returning{
      id
      title
      
    }
  }
}

''';
}
