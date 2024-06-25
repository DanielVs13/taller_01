import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taller_01/main.dart';
import 'package:taller_01/screens/peliculas.dart';

void main() {
  runApp(Iniciar());
}

class Iniciar extends StatelessWidget {
  const Iniciar({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Iniciar Sesion'),
      ),
      body: Column(
        children: [
          Usuario(),
          Password(),
          Boton(context),
        ],
      ),
    );
  }
}

final TextEditingController _controllerEmail = TextEditingController();
final TextEditingController _controllerPass = TextEditingController();

Widget Usuario() {
  return (Container(
    child: TextField(
      style: TextStyle(backgroundColor: Color.fromARGB(255, 55, 199, 192)),
      controller: _controllerEmail,
      decoration: InputDecoration(
          hintText: "Ingresar Usuario",
          fillColor: Color.fromARGB(193, 184, 105, 230),
          filled: true),
    ),
  ));
}

Widget Password() {
  return (Container(
    padding: EdgeInsets.all(10),
    child: TextField(
      controller: _controllerPass,
      obscureText: true,
      decoration: InputDecoration(
          hintText: "Ingresar password",
          fillColor: Color.fromARGB(193, 184, 105, 230),
          filled: true),
      keyboardType: TextInputType.number,
    ),
  ));
}

Widget Boton(context) {
  return (Container(
    child: ElevatedButton(
      onPressed: () {
        login(context);
      },
      child: Text("Ingresar"),
    ),
  ));
}

Future<void> login(context) async {
  try {
    // ignore: unused_local_variable
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _controllerEmail.text, password: _controllerPass.text);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Peliculas(),
      ),
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}
