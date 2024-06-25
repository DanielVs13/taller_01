import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:taller_01/screens/video_player.screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Series());
}

class Series extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: Lista(),
    );
  }
}

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  List<Map<String, dynamic>> peliculasList = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final response = await http.get(Uri.parse(
        'https://github.com/DanielVs13/taller_01/blob/main/lib/screens/pelicula.json'));

    if (response.statusCode == 200) {
      updateProductList(json.decode(response.body));
    } else {
      throw Exception('Error al cargar los datos');
    }
  }

  void updateProductList(List<dynamic> data) {
    List<Map<String, dynamic>> tempList = [];

    data.forEach((element) {
      String? imagenUrl = element['imagen'];
      if (imagenUrl != null && imagenUrl.isNotEmpty) {
        tempList.add({
          "titulo": element['titulo'],
          "imagen": imagenUrl,
          "descripcion":
              element['descripcion'] ?? 'No hay descripción disponible',
          "url": element['url'],
        });
      }
    });

    setState(() {
      peliculasList = tempList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Películas'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            height: 200,
            color: Color.fromARGB(255, 45, 12, 233),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: peliculasList.length,
              itemBuilder: (context, index) {
                String? imagenUrl = peliculasList[index]["imagen"];
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => VideoPlayerScreen(
                              videoUrl: peliculasList[index]["url"]),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        imagenUrl ?? '',
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(
            height: 20,
            child: Container(color: Color.fromARGB(255, 44, 13, 221)),
          ),
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                childAspectRatio: 0.75,
              ),
              itemCount: peliculasList.length,
              itemBuilder: (context, index) {
                String? imagenUrl = peliculasList[index]["imagen"];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerScreen(
                            videoUrl: peliculasList[index]["url"]),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 5.0,
                    color: Colors.grey[850],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Expanded(
                          child: imagenUrl != null && imagenUrl.isNotEmpty
                              ? Image.network(
                                  imagenUrl,
                                  fit: BoxFit.cover,
                                )
                              : Placeholder(),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            peliculasList[index]["titulo"] ?? '',
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: ElevatedButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text(
                                        peliculasList[index]["titulo"] ?? ''),
                                    content: Text(
                                      peliculasList[index]["descripcion"] ?? '',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cerrar'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Más'),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
