
import 'package:flutter_appp/database/app_repository.dart';
import 'package:flutter_appp/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class HomeViewModel extends Cubit<HomeState>{
  final AppRepository repo;

  HomeViewModel({required this.repo}) : super(HomeState.initial());

  Future<void> getList() async {
    try {
      final items = await repo.getList();
      if (items.isEmpty) {
        emit(state.copyWith(isEmpty: true));
      } else {
        emit(state.copyWith(items: items, isEmpty: false));
      }
    } catch (e) {
      print(e);
    }
  }
} 