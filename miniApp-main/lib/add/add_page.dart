import 'package:flutter/material.dart';
import 'package:flutter_appp/add/add_page.dart' as _textEditingController;
import 'package:flutter_appp/database/app_database.dart';
import 'package:flutter_appp/database/local_database.dart';
import 'package:flutter_appp/main.dart';
import 'package:drift/drift.dart' hide Column;


class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final _textEditingController = TextEditingController();
  bool isMessageVisible = false;
  String message = "";

  void _saveTodo() async {
    String title = _textEditingController.text.trim();

    try {
      if (title.length < 3) {
        throw TextFieldLengthException("min symbols = 3");
      } else if (title.length > 50) {
        throw TextFieldLengthException("max symbols = 50");
      }

      final allTodos = await appDatabase.select(appDatabase.todos).get();
      
      final bool exists = allTodos.any(
        (todo) => todo.title.toLowerCase() == title.toLowerCase()
      );

      if (exists) {
        throw LocalDatabaseException("Такая задача уже есть");
      }

      await appDatabase.insertTodo(TodosCompanion.insert(
        title: title,
        date: DateTime.now().toString(),
        test: '', 
      ));

      if (mounted) {
        Navigator.pop(context, title);
      }

    } catch (e) {
      
      setState(() {
        message = e.toString();
        isMessageVisible = true;
      });
    }
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Task"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: "Enter task name...",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            
            Visibility(
              visible: isMessageVisible,
              child: Text(
                message,
                style: const TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
            
            const Spacer(),
            
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveTodo,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text("Save Task"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextFieldLengthException implements Exception {
  final String message;
  TextFieldLengthException(this.message);

  @override
  String toString() => message;
}