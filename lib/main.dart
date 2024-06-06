import 'package:flutter/material.dart';
import 'package:taller_01/screens/iniciar.dart';
import 'package:taller_01/screens/registro.dart';

void main() {
  runApp(Taller1());
}

class Taller1 extends StatelessWidget {
  const Taller1({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
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
        title: const Text("Taller 1"),
      ),
      body: Cuerpo(context),
    );
  }
}

Widget Cuerpo(context) {
  return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(
                  "https://cdn.pixabay.com/photo/2018/09/03/23/56/sea-3652697_1280.jpg"),
              fit: BoxFit.cover)),
      child: Column(children: [
        Text(
          "Bienvenido",
          style:
              TextStyle(fontSize: 30, color: Color.fromARGB(255, 46, 38, 45)),
        ),
        BotonInicio(context),
        BotonRegistro(context),
      ]));
}

Widget BotonInicio(context) {
  return (FilledButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Iniciar()));
      },
      child: Text("Iniciar Sesion")));
}

Widget BotonRegistro(context) {
  return (FilledButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const Registro()));
      },
      child: Text("Registrarse")));
}
