import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'styles.dart'; // Importa el template de estilos

class RecoveryPage extends StatefulWidget {
  @override
  _RecoveryPageState createState() => _RecoveryPageState();
}

class _RecoveryPageState extends State<RecoveryPage> {
  final _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  Future<void> _resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      // Muestra un mensaje al usuario indicando que se envió el correo electrónico
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Se envió un correo electrónico para restablecer la contraseña')),
      );
      _emailController.clear();
    } on FirebaseAuthException catch (e) {
      // Maneja los errores de Firebase, como un correo electrónico inválido
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content:
                Text('Error al enviar el correo electrónico de recuperación')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text('Recuperar Clave', style: AppTheme.headline1), // Aplica estilo
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // Agrega la imagen del logotipo aquí
            Image.asset(
              'assets/logo.png', // Reemplaza con la ruta de tu imagen
              height: 180, // Ajusta el tamaño según tus necesidades
            ),
            TextField(
              controller: _emailController,
              decoration: AppTheme.inputDecoration.copyWith(
                labelText: 'Email',
                prefixIcon: Icon(Icons.email), // Agrega un icono
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Llama a la función para recuperar la contraseña
                _resetPassword(_emailController
                    .text); // Pasa el correo electrónico del usuario
              },
              child: Text('Recuperar Contraseña'),
            ),
          ],
        ),
      ),
    );
  }
}
