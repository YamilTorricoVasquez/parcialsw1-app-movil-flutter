import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BoletinScreen extends StatefulWidget {
  final String ci;
  final String anio;

  BoletinScreen(this.ci, this.anio);

  @override
  _BoletinScreenState createState() => _BoletinScreenState();
}

class _BoletinScreenState extends State<BoletinScreen> {
  Map<String, dynamic> _boletinData = {};
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    fetchBoletin();
  }

  void _showAlert(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Alerta'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void fetchBoletin() async {
    try {
      String apiUrl =
          'http://3.144.128.129:8069/api/boletin/${widget.ci}/${widget.anio}';
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        if (data['boletin'] != null) {
          setState(() {
            _boletinData = data['boletin'];
            _isLoading = false;
          });
        } else {
          _showAlert(
              'No se encontró ningún boletín para el CI y año proporcionados.');
              
        }
      } else {
        throw Exception('Ingrese el CI de su hijo.');
      }
    } catch (e) {
      _showAlert(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(child: CircularProgressIndicator())
        : _error.isNotEmpty
            ? Center(child: Text(_error))
            : ListView(
                padding: EdgeInsets.all(16.0),
                children: <Widget>[
                  Center(
                    child: Text(
                      'Libreta del estudiante',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue[900]),
                    ),
                  ),
                  Divider(),
                  Text('Informacion del estudiante',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ListTile(
                    title: Text('Estudiante: ${_boletinData['estudiante']}'),
                    subtitle:
                        Text('CI Estudiante: ${_boletinData['ci_estudiante']}'),
                  ),
                  ListTile(
                    title: Text('Curso: ${_boletinData['curso']}'),
                    subtitle: Text('Nivel: ${_boletinData['nivel']}'),
                  ),
                  ListTile(
                    title: Text(
                        'Estado de Aprobación: ${_boletinData['estado_aprobacion']}'),
                    subtitle: Text('Promedio: ${_boletinData['promedio']}'),
                  ),
                  Divider(),
                  Text('Notas',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ...(_boletinData['notas'] as List).map((nota) => ListTile(
                        title: Text('Materia: ${nota['materia']}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nota: ${nota['nota']}'),
                            Text('Trimestre: ${nota['trimestre']}'),
                            Text('Año: ${nota['anio']}'),
                          ],
                        ),
                      )),
                    
                ],
              );
  }
}
