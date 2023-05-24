import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../entities/Todo.dart';

class Home extends StatefulWidget {
  const Home ({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Todo> todoList = [];
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final todoTextController = TextEditingController();

  void handleAddTodo(String text) {
      setState(() {
        todoList.add(Todo(Uuid().v4(), text, false));
      });
      todoTextController.clear();
  }


  void handleDelete(String id) {
    setState(() {
      todoList.removeWhere((element) => element.id == id);
    });
  }

  void handleToggle(int index) {
    setState(() {
     todoList[index].isDone = !todoList[index].isDone;
    });
  }

  @override
  void initState() {
    super.initState();


    todoList.addAll([
      Todo('1', 'Писать лист на С++', true),
      Todo('2', 'Найти нормальный проект', true),
      Todo('3', 'Получить повышение зп', true),
    ]);
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('TodoList'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 60.0),
        child: Column(
          children: [
            Form(
                child: Row(
                  children: [
                    Flexible(
                      child:  TextFormField(
                        controller: todoTextController,
                        decoration: const InputDecoration(
                          hintText: 'Enter your todo',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please add todo title';
                          }

                          return null;
                        },
                      ),
                    ),
                    IconButton(
                        onPressed: () => handleAddTodo(todoTextController.text),
                        icon: const Icon(
                          Icons.add,
                          color: Colors.blueAccent,
                        )),
                  ],
                )
            ),
            Flexible(child:
                 ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (BuildContext context, int index){
                  return Row(
                    children: [
                      Checkbox(value: todoList[index].isDone, onChanged: (bool) => handleToggle(index)),
                      GestureDetector(
                        child: Text(todoList[index].title, style: TextStyle(
                            fontSize: 20,
                            decoration: todoList[index].isDone
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),),
                      ),
                      IconButton(
                          onPressed: () => handleDelete(todoList[index].id),
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ],
                  );
                })),
          ],
        ),
      )
    );
  }
}
