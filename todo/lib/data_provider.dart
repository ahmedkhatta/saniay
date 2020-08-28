import 'package:flutter/foundation.dart';


class DataProvider extends ChangeNotifier {
  List<TaskModel> tasksList = [
    TaskModel(title: 'Eggs')
  ];

  void addTask(String newTaskTitle){
    final task = TaskModel(title: newTaskTitle);
    tasksList.add(task);
    notifyListeners();
  }

  toggleCheck(){
    TaskModel().toggleCheck();
    notifyListeners();
  }

}

class TaskModel {
  final String title;
  bool isChecked;
  TaskModel({this.title,this.isChecked = false });
  toggleCheck(){ isChecked = !isChecked; }
}