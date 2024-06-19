import 'package:app/firebase_services.dart';
import 'package:app/scaffold_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ScaffoldRegistro extends StatefulWidget {
  const ScaffoldRegistro({super.key});

  @override
  State<ScaffoldRegistro> createState() => _ScaffoldRegistroState();
}

const List<String> list = <String>['Profesor', 'Estudiante', 'Padre'];

class _ScaffoldRegistroState extends State<ScaffoldRegistro> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _ci = '';
  String _nombre = '';
  String _aPaterno = '';
  String _aMaterno = '';
  String _rol = '';
  bool _isLoading = false;
  bool _isObscure = true;
  String dropdownValue = list.first.toString();
  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  void initState() {
    super.initState();
    dropdownValue = list.first;
  }

  void _register() async {
    setState(() {
      _isLoading = true;
    });

    // Simula una llamada de red con un retraso
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential =
            await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        );

        datosPadres(_nombre, _ci, _email, _aPaterno, _aMaterno, _rol);

        // Navigate to home screen or show a success message
      } on FirebaseAuthException catch (e) {
        // Handle error
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text(
          'Registro de usuario',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.grey[900],
        leading: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey,
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffoldlogin(),
                    ));
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Image.asset("images/LogoSw.png"),
                // Icon(Icons.person_add_alt_outlined),
                SizedBox(height: 25),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(blurRadius: 10, spreadRadius: 0.8),
                    ],
                    color: Colors.grey[300],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Nombre',
                        border: InputBorder.none,
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese su nombre';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _nombre = value;
                        });
                      },
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(blurRadius: 10, spreadRadius: 0.8),
                    ],
                    color: Colors.grey[300],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Apellido paterno',
                          border: InputBorder.none),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese su apellido paterno';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _aPaterno = value;
                        });
                      },
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(blurRadius: 10, spreadRadius: 0.8),
                    ],
                    color: Colors.grey[300],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Apellido materno',
                          border: InputBorder.none),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese su apellido materno';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _aMaterno = value;
                        });
                      },
                      textCapitalization: TextCapitalization.words,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(blurRadius: 10, spreadRadius: 0.8),
                    ],
                    color: Colors.grey[300],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Cedula de identidad',
                          border: InputBorder.none),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Ingrese su Cedula de identidad';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _ci = value;
                        });
                      },
                      maxLength: 7,
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                    ),
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(blurRadius: 10, spreadRadius: 0.8),
                    ],
                    color: Colors.grey[300]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "ROL: ",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                              color: Colors.blue[900]),
                        ),
                        DropdownMenu<String>(
                          initialSelection: list.first,
                          onSelected: (String? value) {
                            // This is called when the user selects an item.
                            setState(() {
                              dropdownValue = value!;
                              _rol = value;
                            });
                          },
                          dropdownMenuEntries: list
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry<String>(
                                value: value, label: value);
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(blurRadius: 10, spreadRadius: 0.8),
                    ],
                    color: Colors.grey[300],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Correo electronico',
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.email_outlined)),
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
                SizedBox(height: 15),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    boxShadow: [
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
                SizedBox(height: 15),
                InkWell(
                  onTap: _register,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(blurRadius: 10, spreadRadius: 0.8)
                          ]),
                      child: Center(
                        child: _isLoading
                            ? CircularProgressIndicator(
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.black),
                              )
                            : Text(
                                "Registrarse",
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

                SizedBox(height: 45),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
