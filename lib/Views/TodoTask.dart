import 'package:app/Controllers/TodoController.dart';
import 'package:app/Models/TodoModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TodoTask extends StatelessWidget {
  final TodoController todoController = Get.find();
  final index;
  TodoTask({this.index});
  @override
  Widget build(BuildContext context) {
    String textfield = "";
    if(this.index != null){
      textfield = todoController.todos[index].text;
    }else{
      textfield = "";
    }
    TextEditingController textEditingController = TextEditingController(
      text: textfield
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.all(35),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                controller: textEditingController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "What do you want to accomplish ?",
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none
                ),
                style: TextStyle(fontSize: 25.0),
                keyboardType: TextInputType.multiline,
                maxLines: 1000,
              )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    child: Text("Cancel"),
                    color: Colors.red,
                    onPressed: (){
                      Get.back();
                    }),
                    RaisedButton(
                  child: Text((this.index == null) ? 'Add' : 'Edit'),
                  color: Colors.green,
                  onPressed: () {
                    if (this.index == null) {
                      todoController.todos
                          .add(TodoModel(text: textEditingController.text));
                    } else {
                      var editing = todoController.todos[index];
                      editing.text = textEditingController.text;
                      todoController.todos[index] = editing;
                    }

                    Get.back();
                  },
                ),
                ],
              )
          ],
        ),
      ),
    );
  }
}