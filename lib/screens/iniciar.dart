import 'package:flutter/material.dart';
import 'package:taller_01/main.dart';

void main(){
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
      body: Container(),
    );
  }
}