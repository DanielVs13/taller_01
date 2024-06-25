import 'package:flutter/material.dart';
import 'package:taller_01/main.dart';
import 'package:taller_01/screens/iniciar.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() {
  runApp(Registro());
}

class Registro extends StatelessWidget {
  const Registro({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Firebase",
      theme: ThemeData.dark(),
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
        title: const Text("Registro"),
      ),
      body: Body(context),
    );
  }
}

final TextEditingController _controllerEmail = TextEditingController();
final TextEditingController _controllerPass = TextEditingController();

Widget Body(context) {
  return Scaffold(
    body: Container(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "Registro",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controllerEmail,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 105, 58, 58),
                  hintText: "Correo Electrónico",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _controllerPass,
                obscureText: true,
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Color.fromARGB(255, 105, 58, 58),
                  hintText: "Contraseña",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  login(context);
                },
                child: const Text(
                  "Registrar",
                  style: TextStyle(color: Color.fromARGB(255, 27, 203, 209)),
                ),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Taller1(),
                    ),
                  );
                },
                child: const Text(
                  "Regresar",
                  style: TextStyle(
                    color: Color.fromARGB(255, 57, 214, 17),
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

Widget BotonVolver(context) {
  return (ElevatedButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Taller1()));
      },
      child: const Text("Ir Login")));
}

Future<void> login(context) async {
  try {
    final credential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _controllerEmail.text,
      password: _controllerPass.text,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Iniciar(),
      ),
    );
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
