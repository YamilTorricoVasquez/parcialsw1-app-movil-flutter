import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Horario {
  final String curso;
  final String nivel;
  final String materia;
  final String aula;
  final String startTime;
  final String endTime;

  Horario({
    required this.curso,
    required this.nivel,
    required this.materia,
    required this.aula,
    required this.startTime,
    required this.endTime,
  });

  factory Horario.fromJson(Map<String, dynamic> json) {
    return Horario(
      curso: json['curso'],
      nivel: json['nivel'],
      materia: json['materia'],
      aula: json['aula'],
      startTime: json['start_time'],
      endTime: json['end_time'],
    );
  }
}

Future<List<Horario>> fetchHorario(String ci) async {
  final response = await http
      .get(Uri.parse('http://3.144.128.129:8069/api/horario/profesor/$ci'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body)['horarios'];
    return data.map((json) => Horario.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load horarios');
  }
}

class HorarioProfesor extends StatefulWidget {
  final String ci;

  HorarioProfesor({required this.ci});

  @override
  _HorarioProfesorState createState() => _HorarioProfesorState();
}

class _HorarioProfesorState extends State<HorarioProfesor> {
  late Future<List<Horario>> futureHorarios;

  @override
  void initState() {
    super.initState();
    futureHorarios = fetchHorario(widget.ci);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
        Text("HORARIO",style: TextStyle(color: Colors.black,fontSize: 30,fontWeight: FontWeight.bold),),
        Divider(indent: 20,endIndent: 20,),
        FutureBuilder<List<Horario>>(
          future: futureHorarios,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No se encontraron horarios'));
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final horario = snapshot.data![index];
                    return ListTile(
                      title: Text(
                        horario.materia,
                        style: TextStyle(color: Colors.blue[900],fontWeight: FontWeight.bold,fontSize: 19),
                      ),
                      subtitle: Text(
                        'Curso: ${horario.curso}\nNivel: ${horario.nivel}\nAula: ${horario.aula}\nHora Inicio: ${horario.startTime}\nHora Fin: ${horario.endTime}',
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 15),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
