import 'package:flutter/material.dart';
import 'customWidgets.dart';
import 'package:provider/provider.dart';
import 'data_provider.dart';


class TasksScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var screenData = MediaQuery.of(context);

    String newTaskTitle;

    return Consumer<DataProvider>(
      builder: (context,dataProvider ,child){
        return Scaffold(
          backgroundColor: Colors.lightBlueAccent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(40, 80, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(child: Icon(Icons.list, size: 30, color: Colors.lightBlueAccent,),backgroundColor: Colors.white, radius: 30, ),
                    SizedBox(height: 10,),
                    Text('Todoey', style: TextStyle(fontSize: 40,fontWeight: FontWeight.bold,color:Colors.white ),),
                    Text('${dataProvider.tasksList.length} Tasks' ,style: TextStyle(fontSize: 18,color: Colors.white),),
                    SizedBox(height: 20,),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  width: screenData.size.width,
                  decoration: BoxDecoration(color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30),),),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(30, 0 , 30, 0),
                    child: dataProvider.tasksList.length != 0
                        ? ListView.builder(
                      itemCount: dataProvider.tasksList.length,
                      itemBuilder: (context,index){
                        return TaskTile(
                          taskTitle: dataProvider.tasksList[index].title,
                          isChecked: dataProvider.tasksList[index].isChecked,
                          checkBoxStateCallBack: (val){},
                          onLongPressCallBack: (){},
                        );
                      },
                    )
                        : Center(child: Text('No Tasks Yet',style: TextStyle(color: Colors.redAccent),),
                    ),
                  ),
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: (){
              showModalBottomSheet(
                context: context,
                builder: ( context) => Container(
                  color: Color(0xff757575),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30),)
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(50),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: <Widget>[
                          Text('Add Task',textAlign: TextAlign.center,style: TextStyle(fontSize: 30,fontWeight: FontWeight.w400,color: Colors.lightBlueAccent),),
                          TextField(
                            textAlign: TextAlign.center,
                            onChanged: (value){
                              newTaskTitle = value ;
                            },
                          ),
                          SizedBox(height: 20,),
                          Container(
                            height: 40,
                            child: RaisedButton(
                              elevation: 0,
                              onPressed: (){
                                dataProvider.addTask(newTaskTitle);
                                Navigator.pop(context);
                              },
                              color: Colors.lightBlueAccent,
                              child: Text('Add',style: TextStyle(color: Colors.white),),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.lightBlueAccent,
          ),
        );
      },
    );
  }
}
