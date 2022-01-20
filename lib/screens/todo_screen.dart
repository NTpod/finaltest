import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:finaltest/utils/drawler.dart';
import 'package:finaltest/utils/todos.dart';
import 'package:finaltest/utils/users.dart';
import 'package:http/http.dart' as http;

class LoadTodo extends StatefulWidget {
  static String rote = 'LoadTodo';
  final User user;
  const LoadTodo(this.user, {Key? key}) : super(key: key);

  @override
  _LoadTodoState createState() => _LoadTodoState();
}

class _LoadTodoState extends State<LoadTodo> {
  Future<List<Todo>> fetchTodos() async {
    var responseT = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/todos?userId=${widget.user.id.toString()}' )
    );
    if (responseT.statusCode == 200) {
      List todoResponse = json.decode(responseT.body);
      return todoResponse.map((t) => Todo.fromJson(t)).toList();
    } else {
      throw Exception(
          'Failed to load' + widget.user.username.toString() + "'s todos"
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer:  navDrawer(context),
        appBar: AppBar(
            backgroundColor: Colors.deepOrange[400],
            title: const Text('Список задач'),
            centerTitle: true,
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/auth');
                },
                child: const Text('Выйти', style: TextStyle(color: Colors.white)),
              )
            ]),
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: FutureBuilder(
            future: fetchTodos(),
            builder: (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
              if (snapshot.hasData) {
                return ListView(
                  padding: const EdgeInsets.all(10.0),
                  children: [
                    ListTile(

                      title: Text('Имя', style: Theme.of(context).textTheme.bodyText2),
                      subtitle: Text(widget.user.name.toString(), style: Theme.of(context).textTheme.headline6),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.phone, size: 30,),
                      title: Text('Телефон', style: Theme.of(context).textTheme.bodyText2),
                      subtitle: Text(widget.user.phone.toString(), style: Theme.of(context).textTheme.headline6),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.email, size: 30,),
                      title: Text('Email', style: Theme.of(context).textTheme.bodyText2),
                      subtitle: Text(widget.user.email.toString(), style: Theme.of(context).textTheme.headline6),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.public, size: 30,),
                      title: Text('Сайт', style: Theme.of(context).textTheme.bodyText2),
                      subtitle: Text(widget.user.website.toString(), style: Theme.of(context).textTheme.headline6),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.place, size: 30,),
                      title: Text(widget.user.address!.city.toString(), style: Theme.of(context).textTheme.headline6),
                      subtitle: Text('${widget.user.address!.zipcode.toString()} ${widget.user.address!.street.toString()} ${widget.user.address!.suite.toString()} \n[${widget.user.address!.geo!.lat.toString()}:${widget.user.address!.geo!.lng.toString()}]',),
                      isThreeLine: true,
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.business, size: 30,),
                      title:  Text(widget.user.company!.name.toString(), style: Theme.of(context).textTheme.headline6),
                      subtitle: Text('${widget.user.company!.bs.toString()} \n${widget.user.company!.catchPhrase.toString()}',),
                      isThreeLine: true,
                    ),
                    const Divider(),
                    for (var todo in snapshot.data!)
                      Card(
                        elevation: 5,
                        child: ListTile(
                          tileColor: Colors.deepOrangeAccent,
                          textColor: Colors.white,
                          onTap: () {},
                          title: Text(todo.title.toString()),
                          trailing:
                          Checkbox(value: todo.completed, onChanged: null),
                        ),
                      ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        )
    );
  }
}