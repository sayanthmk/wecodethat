import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wecodethat/model/todo.dart';

class TodoProvider with ChangeNotifier {
  final Box<ToDo> _todoBox;
  String? selectedImagePath;

  TodoProvider() : _todoBox = Hive.box<ToDo>('todo');

  List<ToDo> get names => _todoBox.values.toList();

  void addtodo(
    String title,
    String description,
  ) {
    _todoBox.add(ToDo(title: title, description: description));
    notifyListeners();
  }

  void updatetodo(
    int index,
    String title,
    String description,
  ) {
    _todoBox.putAt(index, ToDo(title: title, description: description));
    notifyListeners();
  }

  void deleteTodo(int index) {
    _todoBox.deleteAt(index);
    notifyListeners();
  }

  void clearSelectedImage() {
    selectedImagePath = null;
    notifyListeners();
  }
}
