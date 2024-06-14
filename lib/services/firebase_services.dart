import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;

//creacion de la funcion asincrona que retorna una lista llamada usuarios
Future<List> getUsuario() async{
  List usuarios = [];

  QuerySnapshot querySnapshot = await db.collection('usuarios').get();
  for(var doc in querySnapshot.docs){
    final Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    final person = {
      "nombre": data['nombre'],
      "uid": doc.id,
    };
    usuarios.add(person);
  }
  // //referencia a la coleccion
  // CollectionReference collectionReferencePersonas = db.collection('usuarios');

  // /*
  // 1/ creacion de un objeto de tipo QuerySnapshot
  // 2. await espera de la coleccion  collectionReferencePersonas
  // 3. Uso del get para extraer toda la indormacion de la bd
  // */ 

  // QuerySnapshot queryUsuarios = await collectionReferencePersonas.get();

  //   //ciclo para recorrer todos los registros (documentos)
  //   queryUsuarios.docs.forEach((documento) {
  //   //en cada iteracion recorre un registro
  //   usuarios.add(documento.data());
   
  //  });

   //await para definir el timepo de carga
   await Future.delayed(Duration(seconds: 3));
  return usuarios;
}

//gaurdaar en base de datos
Future<void> addUsuario(String nombre) async{
  await db.collection('usuarios').add({"nombre": nombre});
}

//actualizar base de datos
Future<void> updateUsuario(String uid, String newName) async{
  await db.collection('usuarios').doc(uid).set({"nombre": newName});
}

//eliminar datos de la db
Future<void> deleteUsuario (String uid)async{
  await db.collection("usuarios").doc(uid).delete();
}