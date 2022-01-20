import 'package:flutter/material.dart';

Widget navDrawer(context) => Drawer(
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      DrawerHeader(
        decoration: const BoxDecoration(
          color: Colors.deepOrangeAccent,
        ),
        child: SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height : 100,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(50.0))
                ),
                child: const Image(image: AssetImage('assets/logo.png')),
              ),
                          ],
          ),
        ),
      ),
      ListTile(
        leading: const Icon(Icons.home),
        title: const Text('Пользователи', style: TextStyle(fontSize: 18,),),
        onTap: (){
          Navigator.pushNamed(context, '/main_screen');
        },
      ),
      const Divider(color: Colors.orangeAccent, indent: 25, endIndent: 25,),
      ListTile(
        leading: const Icon(Icons.info),
        title: const Text('Информация', style: TextStyle(fontSize: 18,),),
        onTap: (){
          Navigator.pushNamed(context, '/about_screen');
        },
      ),
      const Divider(color: Colors.orangeAccent, indent: 25, endIndent: 25,),
      const SizedBox(height: 300,),
      const Center(child: Text('2022')),
    ],
  ),
);