import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/todos_model.dart';
import 'screens/home_screen.dart';



void main() => runApp(TodosApp());

class TodosApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //add.................................
    final ThemeData themeData = ThemeData();
    return ChangeNotifierProvider(
        create: (context) => TodosModel(),
        child: MaterialApp(
          title: 'Todos',
          theme: themeData.copyWith(
            colorScheme: themeData.colorScheme.copyWith(
                primary: Colors.blue, secondary: Colors.red
            )
          ),
          home: HomeScreen(),
        ),
    );
  }
}