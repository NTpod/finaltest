import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:finaltest/screens/todo_screen.dart';
import 'package:finaltest/utils/drawler.dart';
import 'package:finaltest/utils/users.dart';
import 'package:http/http.dart' as http;

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

Future<List<User>> fetchUsers() async {
  final response = await http
      .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((user) => User.fromJson(user)).toList();
  } else {
    throw Exception('Ошибка загрузки пользователей');
  }
}


class _MainScreenState extends State<MainScreen> {
  late Future<List<User>> futureUsers;

  @override
  void initState() {
    super.initState();
    futureUsers = fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: navDrawer(context),
      appBar: AppBar(
          backgroundColor: Colors.deepOrange[400],
          title: const Text('Список пользователей'),
          centerTitle: true,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/auth');
                },
              child: const Text('Выйти', style: TextStyle(color: Colors.white)),
            )
          ]),
          body: Center(
            child: FutureBuilder<List<User>>(
              future: futureUsers,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return _userListView(context, snapshot.data!);
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }

                return const CircularProgressIndicator();
              },
            ),
          ),
        );
      }
}

ListView _userListView(BuildContext context, List<User>data) {
  return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _userListTile(context, data[index]);
      });
}

Card _userListTile(BuildContext context, User data) {
  return Card(
    child:
      ListTile(
      leading:
      Text(data.id.toString(), textAlign:TextAlign.center , style: const TextStyle(fontSize: 35, color: Colors.indigo),),
      title: Text(
        data.name.toString(),
        style: Theme.of(context).textTheme.headline6,
      ),
      subtitle: Text(
        data.email.toString(),
        style: Theme.of(context).textTheme.bodyText2,
      ),
      trailing: const Icon(Icons.more_vert),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => LoadTodo(data)));
      }
    ),
  );
}