import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/tarea_provider.dart';

class TareaItem extends StatelessWidget {
  final int index;

  TareaItem({required this.index});

  Future<bool> _confirmarEliminacion(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmar eliminación"),
          content: Text("¿Estás seguro de que deseas eliminar esta tarea?"),
          actions: [
            TextButton(
              child: Text("Cancelar"),
              onPressed: () => Navigator.of(context).pop(false),
            ),
            ElevatedButton(
              child: Text("Eliminar"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tareaProvider = Provider.of<TareaProvider>(context);
    final tarea = tareaProvider.tareas[index];

    return Dismissible(
      key: Key(tarea.titulo),
      background: Container(
          color: Colors.red, child: Icon(Icons.delete, color: Colors.white)),
      confirmDismiss: (direction) async {
        return await _confirmarEliminacion(context);
      },
      onDismissed: (direction) {
        tareaProvider.eliminarTarea(index);
      },
      child: Card(
        color: tarea.completada ? Colors.green.shade100 : Colors.white,
        child: ListTile(
          title: Text(
            tarea.titulo,
            style: TextStyle(
              decoration: tarea.completada ? TextDecoration.lineThrough : null,
            ),
          ),
          subtitle: Text(tarea.descripcion),
          trailing: Checkbox(
            value: tarea.completada,
            onChanged: (_) => tareaProvider.marcarCompletada(index),
          ),
        ),
      ),
    );
  }
}
