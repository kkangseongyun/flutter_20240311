import 'package:flutter/material.dart';

//데이터 VO
class Todo {
  String title;
  bool completed;

  Todo({required this.title, this.completed = false});

  void toggleCompleted() {
    completed = !completed;
  }
}

