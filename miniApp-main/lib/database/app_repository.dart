import 'package:flutter_appp/database/app_database.dart';
import 'package:flutter_appp/database/todos.dart';



abstract class AppRepository {
  Future <List<Todo>> getList();
}

class AppRepositoryImplementation extends AppRepository {
  final AppDatabase db;

  AppRepositoryImplementation({required this.db});

  @override
  Future <List<Todo>> getList() => db.getTodoList();
}