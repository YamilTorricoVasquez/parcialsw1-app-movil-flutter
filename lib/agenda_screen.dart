import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgendaScreen extends StatefulWidget {
  @override
  _AgendaScreenState createState() => _AgendaScreenState();
}

class _AgendaScreenState extends State<AgendaScreen> {
  List<dynamic> comunicados = []; // Lista para almacenar los comunicados

  // Función para obtener los comunicados desde la API
  Future<void> fetchComunicados() async {
    final response =
        await http.get(Uri.parse('http://3.144.128.129:8069/api/comunicado'));

    if (response.statusCode == 200) {
      setState(() {
        comunicados = json.decode(response.body)['data'];
      });
    } else {
      // Manejar el error si la solicitud no fue exitosa
      print('Error al cargar los comunicados: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchComunicados(); // Llamar a la función al cargar la pantalla
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: comunicados.length,
        itemBuilder: (context, index) {
          var comunicado = comunicados[index];
          return ListTile(
            title: Text(comunicado['name']),
            subtitle: Text(comunicado['contenido']),
            trailing: Text(comunicado['fecha_publicacion']),
          );
        },
      ),
    );
  }
}
