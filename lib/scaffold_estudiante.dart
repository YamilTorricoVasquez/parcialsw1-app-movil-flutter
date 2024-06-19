import 'package:app/firebase_services.dart';
import 'package:app/horario_estudiante_api.dart';
import 'package:app/scaffold_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScaffoldEstudiante extends StatefulWidget {
  const ScaffoldEstudiante({super.key});

  @override
  State<ScaffoldEstudiante> createState() => _ScaffoldEstudianteState();
}

class _ScaffoldEstudianteState extends State<ScaffoldEstudiante> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? _nombre;

  String? _apaterno;

  String? _amaterno;

  Widget body = Text("INICIO");

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  Future<void> _initializeUserData() async {
    User? usuario = _auth.currentUser;
    if (usuario != null) {
      String? paterno = await getApellidoPaterno(usuario.email!);
      String? materno = await getApellidoMaterno(usuario.email!);
      String? nombre = await getNombrePadre(usuario.email!);
      setState(() {
        _nombre = nombre;
        _apaterno = paterno;
        _amaterno = materno;
      });
    }
  }

  void _logout() async {
    await _auth.signOut();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Scaffoldlogin()),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? usuario = _auth.currentUser;
    final _formKey = GlobalKey<FormState>();
    TextEditingController ciController = TextEditingController();
    TextEditingController anioController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          'Bienvenido ${_nombre ?? ''}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.grey[900],
        shadowColor: Colors.blue,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        body = Center(
                          child: Text("INICIO"),
                        );
                      });
                    },
                    icon: Icon(
                      Icons.dashboard,
                      size: 45,
                    ),
                  ),
                  Text(_nombre ?? ''),
                  Text('${_apaterno ?? ''} ${_amaterno ?? ''}'),
                  Text(usuario!.email as String)
                ],
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 12,
                            spreadRadius: 0.10,
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: TextFormField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText:
                                "Ingrese su CI", // Cambiado label a labelText
                          ),
                          controller: ciController,
                          maxLength: 7,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el CI';
                            }
                            if (value.length < 7) {
                              return 'El CI debe tener al menos 7 digitos';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     if (_formKey.currentState!.validate()) {
                  //       // Si el formulario es válido, intenta obtener el boletín
                  //       setState(() {
                  //         body = HorarioPage(
                  //           ci: ciController.text,
                  //         );
                  //       });
                  //     }
                  //   },
                  //   child: Text(
                  //     "Ver horario",
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.black,
                  //     ),
                  //   ),
                  //   style: ButtonStyle(
                  //     backgroundColor: MaterialStateProperty.all(
                  //         Colors.grey), // Cambiado a MaterialStateProperty.all
                  //   ),
                  // ),
                  InkWell(
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // Si el formulario es válido, intenta obtener el boletín
                        setState(() {
                          body = HorarioEstudiante(
                            ci: ciController.text,
                          );
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(blurRadius: 8, spreadRadius: 0.12)
                        ],
                        color: Colors.white,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Ver Horario",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.blue[900],
              height: 66,
              indent: 20,
              endIndent: 20,
            ),
            const SizedBox(height: 30),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.logout),
                title: Text('Cerrar Sesion'),
              ),
              onTap: _logout,
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
