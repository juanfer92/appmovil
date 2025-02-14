import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:gestortareas/providers/tarea_provider.dart';
import 'package:gestortareas/widgets/tarea_item.dart';
import 'add_task_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final tareaProvider = Provider.of<TareaProvider>(context);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple,
                Colors.deepPurple
              ], // Colores del degradado
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: SafeArea(
          bottom: false, // Ajusta el título debajo de la cámara frontal
          child: Text("Gestión de Tareas"),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              _logout();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                // Sección de tareas pendientes
                if (tareaProvider.tareasPendientes.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Tareas Pendientes",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                  ...List.generate(
                    tareaProvider.tareasPendientes.length,
                    (index) => TareaItem(
                        index: tareaProvider.tareas
                            .indexOf(tareaProvider.tareasPendientes[index])),
                  ),
                ],

                // Sección de tareas completadas
                if (tareaProvider.tareasCompletadas.isNotEmpty) ...[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Tareas Completadas",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                  ),
                  ...List.generate(
                    tareaProvider.tareasCompletadas.length,
                    (index) => TareaItem(
                        index: tareaProvider.tareas
                            .indexOf(tareaProvider.tareasCompletadas[index])),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => AddTaskScreen()));
        },
      ),
    );
  }

  void _logout() async {
    try {
      await _auth.signOut();
      Navigator.pushNamed(context, '/login'); // Navega a la pantalla de login
    } catch (e) {
      // Muestra un mensaje de error
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(e.toString()),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }
}
