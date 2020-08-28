import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {

  final bool isChecked;
  final String taskTitle;
  final Function checkBoxStateCallBack;
  final Function onLongPressCallBack;
  TaskTile({this.isChecked, this.taskTitle, this.checkBoxStateCallBack,this.onLongPressCallBack});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress:onLongPressCallBack ,
      title: Text(taskTitle, style: TextStyle(decoration: isChecked ? TextDecoration.lineThrough : null),),
      trailing: Checkbox(
          activeColor: Colors.lightBlueAccent,
          value: isChecked,
          onChanged: checkBoxStateCallBack
      ),
    );
  }
}

//
//class AddTask extends StatelessWidget {
//
//  @override
//  Widget build(BuildContext context) {
//
//    String newTaskTitle;
//
//    return Container(
//      color: Color(0xff757575),
//      child: Container(
//        decoration: BoxDecoration(
//            color: Colors.white,
//            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30),)
//        ),
//        child: Padding(
//          padding: EdgeInsets.all(50),
//          child: Column(
//            crossAxisAlignment: CrossAxisAlignment.stretch,
//            children: <Widget>[
//              Text('Add Task',textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400,color: Colors.lightBlueAccent),),
//              TextField(
//                textAlign: TextAlign.center,
//                onChanged: (value){
//                  newTaskTitle = value ;
//                },
//              ),
//              SizedBox(height: 20,),
//              Container(
//                height: 40,
//                child: RaisedButton(
//                  elevation: 0,
//                  onPressed: (){
//                    Provider.of<DataProvider>(context).addTask(newTaskTitle);
//                    Navigator.pop(context);
//                    },
//                  color: Colors.lightBlueAccent,
//                  child: Text('Add',style: TextStyle(color: Colors.white),),
//                ),
//              )
//            ],
//          ),
//        ),
//      ),
//    );
//  }
//}
