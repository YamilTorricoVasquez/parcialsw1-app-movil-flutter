import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

Future<String?> getNombrePadre(String correo) async {
  DocumentReference documentReferencePadre = db.collection('Padres').doc(correo);
  
  DocumentSnapshot documentSnapshot = await documentReferencePadre.get();
  
  if (documentSnapshot.exists) {
    // Extrae y retorna el campo 'name' del documento encontrado
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return data['name'] as String?;
  } else {
    // Retorna null si no se encuentra el documento
    return null;
  }
}
Future<String?> getApellidoPaterno(String correo) async {
  DocumentReference documentReferencePadre = db.collection('Padres').doc(correo);
  
  DocumentSnapshot documentSnapshot = await documentReferencePadre.get();
  
  if (documentSnapshot.exists) {
    // Extrae y retorna el campo 'name' del documento encontrado
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return data['apaterno'] as String?;
  } else {
    // Retorna null si no se encuentra el documento
    return null;
  }
}
Future<String?> getRol(String correo) async {
  DocumentReference documentReferencePadre = db.collection('Padres').doc(correo);
  
  DocumentSnapshot documentSnapshot = await documentReferencePadre.get();
  
  if (documentSnapshot.exists) {
    // Extrae y retorna el campo 'name' del documento encontrado
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return data['rol'] as String?;
  } else {
    // Retorna null si no se encuentra el documento
    return null;
  }
}
Future<String?> getApellidoMaterno(String correo) async {
  DocumentReference documentReferencePadre = db.collection('Padres').doc(correo);
  
  DocumentSnapshot documentSnapshot = await documentReferencePadre.get();
  
  if (documentSnapshot.exists) {
    // Extrae y retorna el campo 'name' del documento encontrado
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    return data['amaterno'] as String?;
  } else {
    // Retorna null si no se encuentra el documento
    return null;
  }
}



Future<void> add(String name) async {
  await db.collection("tokens").add({"name": name});
}

Future<void> datosPadres(String name, String ci,String correo,String aPaterno,String aMaterno,String rol) async {
 // await db.collection("Datos").add({"name": name, "ci": ci});
  await db.collection("Padres").doc(correo).set({"name": name, "ci": ci,"apaterno":aPaterno,"amaterno":aMaterno,"rol":rol});
}

Future<Map<String, dynamic>?> obtenerDatosPadres(String ci) async {
  try {
    DocumentSnapshot<Map<String, dynamic>> doc =
        await FirebaseFirestore.instance.collection("Padres").doc(ci).get();

    if (doc.exists) {
      // Si el documento existe, retornamos un Map con los datos
      return {"name": doc.data()?["name"], "ci": doc.data()?["ci"],"apaterno":doc.data()?["apaterno"],"amaterno":doc.data()?["amaterno"]};
    } else {
      print("No se encontró el documento.");
      return null;
    }
  } catch (e) {
    print("Error obteniendo el documento: $e");
    return null;
  }
}
