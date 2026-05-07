class TaskModel {
  final String id;
  String title;
  bool isDone;
  DateTime date;

  TaskModel({
    required this.id,
    required this.title,
    this.isDone = false,
    required this.date,
  });
}