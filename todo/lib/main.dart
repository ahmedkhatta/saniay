import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/data_provider.dart';
import 'package:todo/tasks_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) =>  DataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TasksScreen(),
      ),
    );
  }
}
