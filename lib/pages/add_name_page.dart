import 'package:flutter/material.dart';
import 'package:p8/services/firebase_services.dart';

class AddNamePage extends StatefulWidget{
  const AddNamePage({super.key});

  @override 
  State<AddNamePage> createState() => _AddNamePage();
}

class _AddNamePage extends State<AddNamePage>{

  TextEditingController nameController = TextEditingController(text: "");

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 3, 102, 6),
        title: const Text('Agregar Tarea'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
              TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Ingrese la tarea',
              ),
            ),
            ElevatedButton(
              onPressed: () async{
                await addUsuario(nameController.text).then((_) {
                     Navigator.pop(context);
                });
            }, 
              child: const Text('Guardar'))
          ],
        ),
      ),
    );
  }
}

