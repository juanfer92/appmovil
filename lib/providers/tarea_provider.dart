import 'package:flutter/material.dart';
import '../models/tarea.dart';

class TareaProvider with ChangeNotifier {
  List<Tarea> _tareas = [
    Tarea(
        titulo: "Hacer ejercicio",
        descripcion: "30 minutos de cardio",
        completada: false),
    Tarea(
        titulo: "Comprar víveres",
        descripcion: "Frutas, verduras y pan",
        completada: false),
    Tarea(
        titulo: "Leer un libro",
        descripcion: "Leer 10 páginas de un libro",
        completada: true),
    Tarea(
        titulo: "Enviar reporte",
        descripcion: "Enviar informe semanal por correo",
        completada: true),
  ];

  List<Tarea> get tareas => _tareas;
  List<Tarea> get tareasPendientes =>
      _tareas.where((t) => !t.completada).toList();
  List<Tarea> get tareasCompletadas =>
      _tareas.where((t) => t.completada).toList();

  void agregarTarea(String titulo, String descripcion) {
    _tareas.add(Tarea(titulo: titulo, descripcion: descripcion));
    notifyListeners();
  }

  void eliminarTarea(int index) {
    _tareas.removeAt(index);
    notifyListeners();
  }

  void marcarCompletada(int index) {
    _tareas[index].completada = !_tareas[index].completada;
    notifyListeners();
  }
}
