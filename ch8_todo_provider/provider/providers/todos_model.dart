import 'dart:collection';

import 'package:flutter/material.dart';
import '../models/todo.dart';

//값 변경, re-rendering 을 위해서..
class TodosModel extends ChangeNotifier {
  final List<Todo> todos = [];

  void addTodo(Todo todo){
    todos.add(todo);
    //notifyListeners 해야.. 변경된 값 위젯에 반영..
    notifyListeners();
  }
  void toggleTodo(Todo todo){
    final index = todos.indexOf(todo);
    todos[index].toggleCompleted();
    notifyListeners();
  }
  void deleteTodo(Todo todo){
    todos.remove(todo);
    notifyListeners();
  }
}

