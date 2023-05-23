import 'dart:developer';

import 'package:dio/dio.dart' as dio;
import 'package:todo_app/utils/constants.dart';

class TodoService {
  dio.Dio graphqlClient = dio.Dio(dio.BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      contentType: 'application/json',
      responseType: dio.ResponseType.json,
      headers: {
        'x-hasura-admin-secret':
            'ijJe7a3HEnUMXg7VzaZILVa6oMUs58jw3VVKyOsCA0B6IEe9u8c9QA5MH3RomaQb'
      },
      sendTimeout: const Duration(seconds: 5)));

  getTodos() async {
    try {
      dio.Response response = await graphqlClient.post('', data: {
        "query": Queries.getTodo,
      });
      if (response.statusCode == 200) {
        log(response.data.toString());
        return response.data['data']['todos'];
      } else {
        return null;
      }
    } on dio.DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }

  addTodos(String todo) async {
    try {
      dio.Response response = await graphqlClient.post('', data: {
        "query": Queries.addTodo,
        "variables": {"title": todo}
      });
      if (response.statusCode == 200) {
        return response.data;
      } else {
        return null;
      }
    } on dio.DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }

  todoComplete(int id) async {
    try {
      dio.Response response = await graphqlClient.post('', data: {
        "query": Queries.update,
        "variables": {"id": id}
      });
      if (response.statusCode == 200) {
        return response;
      } else {
        return null;
      }
    } on dio.DioError catch (e) {
      log(e.message.toString());
    }
    return null;
  }

  deleteTodos(int id) async {
    try {
      dio.Response response = await graphqlClient.post('', data: {
        "query": Queries.deleteTodo,
        "variables": {"id": id}
      });
      if (response.statusCode == 200) {
        return response;
      } else {
        return null;
      }
    } on dio.DioError catch (e) {
      log(e.message.toString());
    }
  }
}
