import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'styles.dart'; // Importa el template de estilos

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  void _register() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Navega a la página de login después del registro exitoso
      Navigator.pushReplacementNamed(context, '/login');
    } on FirebaseAuthException catch (e) {
      String mensajeError = 'Error desconocido';

      switch (e.code) {
        case 'weak-password':
          mensajeError = 'La contraseña es demasiado débil.';
          break;
        case 'email-already-in-use':
          mensajeError = 'Ya existe una cuenta con este correo electrónico.';
          break;
        case 'invalid-email':
          mensajeError = 'El correo electrónico no es válido.';
          break;
        //... otros casos de error
      }

      // Muestra un mensaje de error personalizado
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Error al Registrar',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              mensajeError,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registro', style: AppTheme.headline1), // Aplica estilo
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
            SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: AppTheme.inputDecoration.copyWith(
                labelText: 'Password',
                prefixIcon: Icon(Icons.lock), // Agrega un icono
              ),
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: _register,
              child: Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }
}
