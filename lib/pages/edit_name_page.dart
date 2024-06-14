import 'package:flutter/material.dart';
import 'package:p8/services/firebase_services.dart';

class EditNamePage extends StatefulWidget{
  const EditNamePage({super.key});

  @override 
  State<EditNamePage> createState() => _EditNamePage();
}

class _EditNamePage extends State<EditNamePage>{

  TextEditingController nameController = TextEditingController(text: "");

  @override 
  Widget build(BuildContext context){

    final Map arguments = ModalRoute.of(context)!.settings.arguments as Map;
    nameController.text = arguments['nombre'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 102, 6),
        title: const Text('Editar Tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
              TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ingrese la modificacion',
              ),
            ),
            ElevatedButton(
              
              onPressed: () async{
                
                await updateUsuario(arguments['uid'], nameController.text).then((_) {
                  Navigator.pop(context);
                });
            }, 
              child: const Text('Actualizar'))
          ],
        ),
      ),
    );
  }
}

