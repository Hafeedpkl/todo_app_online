class TodoModel {
  int? id;
  String? title;
  bool? isCompleted;
  TodoModel({this.id, this.title, this.isCompleted});
  factory TodoModel.fromJson(Map<String, dynamic> json) => TodoModel(
        id: json['id'],
        title: json['title'],
        isCompleted: json['is_completed'],
      );
}
