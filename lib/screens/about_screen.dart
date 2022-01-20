import 'package:flutter/material.dart';
import 'package:finaltest/utils/drawler.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      drawer: navDrawer(context),
      appBar: AppBar(
          backgroundColor: Colors.deepOrange[400],
          title: const Text('Информация'),
          centerTitle: true,
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/auth');
              },
              child: const Text('Выйти', style: TextStyle(color: Colors.white)),
            )
          ]),
      body: ListView(
          padding: const EdgeInsets.all(10.0),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
            Text('Это приложение создано в 2022 году в рамках обучения на курсе "Разработка кросс-платформенных мобильных приложений на Flutter" УГНТУ ',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,),],
            ),


        ],
      ),
    );
  }
}
