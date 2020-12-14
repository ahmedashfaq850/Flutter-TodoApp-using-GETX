import 'package:app/Controllers/TodoController.dart';
import 'package:app/Views/TodoTask.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final TodoController todoController = Get.put(TodoController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Task',
        child: Icon(Icons.add),
        onPressed: (){
          Get.to(TodoTask());
        },
      ),
      body: Container(
        child: Obx((){
          return ListView.separated(
            itemBuilder: (context, index){
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (context){
                  var removed = todoController.todos[index];
                  todoController.todos.removeAt(index);
                  Get.snackbar('Delete', 'The task ${removed.text} was successfully deleted',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.black54,
                  colorText: Colors.white,
                  mainButton: FlatButton(
                    textColor: Colors.white,
                    onPressed: (){
                    if(removed.isNull){
                      return;
                    }else{
                      todoController.todos.insert(index, removed);
                      removed = null;
                      if(Get.isSnackbarOpen){
                        Get.back();
                      }
                    }
                  }, child: Text('Undo'))
                  );

                },
                  child: ListTile(
                  title: Text(todoController.todos[index].text,
                  style: (todoController.todos[index].done) ? 
                  TextStyle(color: Colors.red, decoration: TextDecoration.lineThrough) 
                  : TextStyle(
                    color: Colors.black
                  ),
                  ),
                  onTap: (){
                    Get.to(TodoTask(index: index));
                  },
                  leading: Checkbox(
                    value: todoController.todos[index].done,
                    onChanged: (newValue){
                      var changed = todoController.todos[index];
                      changed.done = newValue;
                      todoController.todos[index] = changed;
                    },
                  ),
                  trailing: Icon(Icons.chevron_right),
                ),
              );
            }, 
            separatorBuilder: (context, __) => Divider(), 
            itemCount: todoController.todos.length);
        }),
      ),
    );
  }
}