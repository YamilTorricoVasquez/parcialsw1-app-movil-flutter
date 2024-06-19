import 'package:app/api/firebase_api.dart';
import 'package:app/firebase_services.dart';
import 'package:app/scaffold_estudiante.dart';
import 'package:app/scaffold_padres.dart';
import 'package:app/scaffold_profesor.dart';
import 'package:app/scaffold_registro.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Scaffoldlogin extends StatefulWidget {
  const Scaffoldlogin({super.key});

  @override
  State<Scaffoldlogin> createState() => _ScaffoldloginState();
}

class _ScaffoldloginState extends State<Scaffoldlogin> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _rol = '';
  bool _isObscure = true;
  bool _isLoading = false;

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  Future<void> _initializeUserData() async {
    User? usuario = _auth.currentUser;
    if (usuario != null) {
      String? rolUser = await getRol(usuario.email!);
      setState(() {
        _rol = rolUser.toString();
      });
    }
  }

  void _login() async {
    // // Simula una llamada de red con un retraso
    // await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = true;
    });
    if (_formKey.currentState!.validate()) {
      
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password,
        );
       await _initializeUserData();
        // await FirebaseApi().initNotifications();
        if (_rol == 'Profesor') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScaffoldProfesor(),
            ),
          );
        } else {
          if (_rol == 'Padre') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ScaffoldPadres(),
              ),
            );
          } else {
            if (_rol == 'Estudiante') {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ScaffoldEstudiante(),
                ),
              );
            }
          }
        }
      } on FirebaseAuthException {}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 25),
                Image.asset("images/LogoSw.png"),
                const SizedBox(height: 50),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                    boxShadow: const [
                      BoxShadow(blurRadius: 10, spreadRadius: 0.8),
                    ],
                    color: Colors.grey[300],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Correo electronico',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: InputBorder.none),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese su correo';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _email = value;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(25),
                    ),
                    boxShadow: const [
                      BoxShadow(blurRadius: 10, spreadRadius: 0.8),
                    ],
                    color: Colors.grey[300],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Contraseña',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.password),
                          suffixIcon: IconButton(
                              onPressed: _toggleObscure,
                              icon: Icon(_isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility))),
                      obscureText: _isObscure,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese su contrasena';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _password = value;
                        });
                      },
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScaffoldRegistro()),
                        );
                      },
                      child: const Text(
                        'Registrarse',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),

                InkWell(
                  onTap: _login,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: const [
                            BoxShadow(blurRadius: 10, spreadRadius: 0.8)
                          ]),
                      child: Center(
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              )
                            : const Text(
                                "Iniciar Sesion",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                      ),
                    ),
                  ),
                ),
                //
              ],
            ),
          ),
        ),
      ),
    );
  }
}
