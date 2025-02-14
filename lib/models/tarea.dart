class Tarea {
  String titulo;
  String descripcion;
  bool completada;

  Tarea(
      {required this.titulo,
      required this.descripcion,
      this.completada = false});
}
