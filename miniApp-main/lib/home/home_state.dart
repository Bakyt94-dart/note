import 'package:flutter_appp/database/app_database.dart';
import 'package:flutter_appp/database/todos.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomeState {
  final List<Todo> items;
  final bool isEmpty;

  const HomeState({required this.items, required this.isEmpty});

  factory HomeState.initial() => const HomeState(items: [], isEmpty: true);


  HomeState copyWith({List<Todo>? items, bool? isEmpty}) {
    return HomeState(items: items ?? this.items, isEmpty: isEmpty ?? this.isEmpty);
  }
}