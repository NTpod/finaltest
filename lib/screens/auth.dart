import 'package:flutter/material.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return Scaffold(
          appBar: AppBar(title: const Text('Авторизация'), backgroundColor: Colors.deepOrange[400], centerTitle: true,),
          body: ListView(
            children: [
              Padding(
          padding:  const EdgeInsets.all(20.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
          children: const [
            SizedBox(height: 60,),
            SizedBox(width: 118, height: 84, child: Image(image: AssetImage('assets/logo.png')),),
            SizedBox(height: 40,),
            Text('Введите логин и пароль',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Color.fromRGBO(0, 0, 0, 0.6)),),
            SizedBox(height: 40,),
            AuthF(),
            SizedBox(height: 40,),
            SizedBox(height: 32,),
            InkWell(child: const Text('Регистрация',textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, color: Color.fromRGBO(0, 0, 0, 0.6)),),
                ),
            SizedBox(height: 20,),
            InkWell(child: Text('Забыли пароль?', ), )

          ] ,
        ),
      ),
            ],
          )
      );
  }
}

class AuthF extends StatefulWidget {
  const AuthF({Key? key}) : super(key: key);

  @override
  _AuthFState createState() => _AuthFState();
}

class _AuthFState extends State<AuthF> {

  static const borderStyle = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(36)),
      borderSide: BorderSide(
          color: Color(0xFFeceff1), width: 2));

  final _phoneTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  String? message;

  void _auth() {
    final phone = _phoneTextController.text;
    final password = _passwordTextController.text;

    if(phone == 'admin' && password == 'admin'){
      message = null;
      Navigator.of(context).pushReplacementNamed('/main_screen');
    } else {
      message = 'Авторизация не удалась';
    }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    final message = this.message;
    return Column(
      children: [
       if(message != null)...[ Text(
         message,
         style: const TextStyle(
           fontSize: 18,
           color: Colors.red,
         ),
         textAlign: TextAlign.center,
       ),
         const SizedBox(height: 20,),
       ],
       SizedBox(width: 224,
        child: TextField(
          controller: _phoneTextController,
          decoration: const InputDecoration(
            filled:true,
            fillColor: Color(0xFFeceff1),
            enabledBorder: borderStyle,
            focusedBorder: borderStyle,
            labelText: 'Логин',
          ),
        ),
      ),
        const SizedBox(height: 20,),
         SizedBox(width: 224,
          child: TextField(
            obscureText: true,
            controller: _passwordTextController,
            decoration: const InputDecoration(
              filled:true,
              fillColor: Color(0xffeceff1),
              enabledBorder: borderStyle,
              focusedBorder: borderStyle,
              labelText: 'Пароль',
            ),
          ),
        ),
        const SizedBox(height: 40,),
        SizedBox(width: 224, height: 42, child:
        ElevatedButton(onPressed: _auth,
          child: const Text('Войти'),
          style: ElevatedButton.styleFrom(
            primary: const Color(0xFFFF8C00),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(36.0),
            ),
          ),
        ),
        ),
    ],);
  }
}
