import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarea_provider.dart';

class AddTaskScreen extends StatelessWidget {
  final TextEditingController tituloController = TextEditingController();
  final TextEditingController descripcionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          child: Text("Agregar Nueva Tarea"),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.asset(
              'assets/logo.png', // Reemplaza con la ruta de tu imagen
              height: 137, // Ajusta el tamaño según tus necesidades
            ),
            SizedBox(height: 24),
            TextField(
              controller: tituloController,
              decoration: InputDecoration(labelText: "Título"),
            ),
            TextField(
              controller: descripcionController,
              decoration: InputDecoration(labelText: "Descripción"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (tituloController.text.isNotEmpty &&
                    descripcionController.text.isNotEmpty) {
                  Provider.of<TareaProvider>(context, listen: false)
                      .agregarTarea(
                          tituloController.text, descripcionController.text);
                  Navigator.pop(context);
                }
              },
              child: Text("Agregar"),
            ),
          ],
        ),
      ),
    );
  }
}
