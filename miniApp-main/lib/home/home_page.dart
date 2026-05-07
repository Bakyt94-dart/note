import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_appp/add/add_page.dart';
import 'package:flutter_appp/database/app_database.dart';
import 'package:flutter_appp/database/app_repository.dart';
import 'package:flutter_appp/home/home_state.dart';
import 'package:flutter_appp/home/home_view_model.dart';
import 'package:flutter_appp/main.dart';
import 'package:flutter_appp/setting/settings_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final HomeViewModel vm;

  @override
  void initState() {
    super.initState();
    final repo = AppRepositoryImplementation(db: appDatabase);
    vm = HomeViewModel(repo: repo);
    vm.getList();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: vm,
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F9FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            IconButton(
              onPressed: _navigateToSettingsPage,
              icon: const Icon(Icons.settings, color: Colors.grey),
            )
          ],
        ),
        body: BlocBuilder<HomeViewModel, HomeState>(
          builder: (context, state) {
            if (state.isEmpty) {
              return _buildEmptyState();
            } else {
              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 16),
                itemCount: state.items.length,
                itemBuilder: (context, index) {
                  final todo = state.items[index];
                  return _buildTaskCard(todo);
                },
              );
            }
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: 56,
          child: FloatingActionButton.extended(
            onPressed: _navigateToAddPage,
            backgroundColor: const Color(0xFF007AFF), // Акцентный синий
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            label: const Text(
              "+ Добавить задачу",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTaskCard(todo) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF007AFF), 
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.white,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  todo.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                const Row(
                  children: [
                    Icon(Icons.calendar_today, color: Colors.white70, size: 12),
                    SizedBox(width: 4),
                    Text(
                      "14.09.26", 
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "У вас нет задач",
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          const SizedBox(height: 16),
          TextButton(
            onPressed: _navigateToAddPage,
            style: TextButton.styleFrom(foregroundColor: const Color(0xFF007AFF)),
            child: const Text("Добавить первую задачу", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Future<void> _navigateToAddPage() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddPage()),
    );
    vm.getList();
    if (result != null) {
      print("Новая задача: $result");
    }
  }

  void _navigateToSettingsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsPage()),
    );
  }
}