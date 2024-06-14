import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:p8/pages/LoginPage.dart';
import 'package:p8/services/firebase_services.dart';

class Home extends StatefulWidget {
  const Home({
    Key? key,
  }) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [InkWell(
          onTap: (){
            FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginPage())
            , (route) => false);
          },
          child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Icons.exit_to_app),
          ), 
        )],
      
        backgroundColor: const Color.fromARGB(255, 3, 102, 6),
        title: const Text('App Tareas'),
      ),


      body: FutureBuilder(
      future: getUsuario(), 
      builder: ((context, snapshot){
        if(snapshot.hasData){
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              return Dismissible(
                onDismissed: (direction) async{
                  await deleteUsuario(snapshot.data?[index]['uid']);
                  snapshot.data?.removeAt(index);
                },
                confirmDismiss: (direction) async{
                  bool result = false;
                  result = await showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        title: Text("Estas seguro de eliminar a ${snapshot.data?[index]['nombre']}"),
                        actions: [
                          TextButton(
                            onPressed: (){
                            return Navigator.pop(
                              context,
                              false,
                            );
                          }, child: const Text("Cancelar",
                              style: TextStyle(color: Colors.red))),
                          TextButton(
                            onPressed: (){
                            return Navigator.pop(
                              context,
                              true,
                            );
                          }, child: const Text("Si, estoy seguro"))
                        ],
                      );
                  });
                  return result;
                },
                background: Container(
                  color: Colors.red,
                  child: const Icon(Icons.delete),
                ),
                direction: DismissDirection.endToStart,
                key: Key(snapshot.data?[index]['uid']),
                child: ListTile(
                  title: Text(snapshot.data?[index]['nombre']),
                  onTap: () async{
                   await Navigator.pushNamed(context, '/edit', arguments: {
                      "nombre":snapshot.data?[index]['nombre'],
                      "uid":snapshot.data?[index]['uid'],
                    });
                    setState(() {});
                  }, 
                ),
              ); 
            },
            );
          
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
      })
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async{
         await Navigator.pushNamed(context, '/add');
         setState(() {});
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}