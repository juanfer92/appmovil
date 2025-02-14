import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'styles.dart'; // Importa el template de estilos

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth.signInWithEmailAndPassword(
          email: _emailController.text,
          password: _passwordController.text,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Inicio de Sesión exitoso')),
        );
        // Navega a la página principal después del login exitoso
        Navigator.pushReplacementNamed(context, '/inicio');
      } on FirebaseAuthException catch (e) {
        String mensajeError = 'Usuario o clave Incorrecta';

        switch (e.code) {
          case 'user-not-found':
            mensajeError =
                'No se encontró ningún usuario con ese correo electrónico.';
            break;
          case 'wrong-password':
            mensajeError = 'Contraseña incorrecta.';
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
                'Error al Iniciar Sesión',
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión', style: AppTheme.headline1),
        automaticallyImplyLeading: false, // Quita la flecha de regresar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Agrega la imagen del logotipo aquí
              Image.asset(
                'assets/logo.png', // Reemplaza con la ruta de tu imagen
                height: 137, // Ajusta el tamaño según tus necesidades
              ),
              SizedBox(height: 24), // Espacio entre el logo y los campos
              TextFormField(
                controller: _emailController,
                decoration: AppTheme.inputDecoration.copyWith(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un correo electrónico';
                  }
                  if (!value.contains('@')) {
                    return 'Por favor ingrese un correo electrónico válido';
                  }
                  if (!value.contains('.')) {
                    return 'Por favor ingrese un correo electrónico válido';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                decoration: AppTheme.inputDecoration.copyWith(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una contraseña';
                  }
                  return null;
                },
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
                child: Text(
                  '¿No tienes cuenta? Regístrate',
                  style: TextStyle(color: AppTheme.primaryColor),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/recovery');

                  // Lógica para recuperar la contraseña
                  //resetPassword(_emailController.text); // Pasa el correo electrónico del usuario
                },
                child: Text('¿Olvidaste tu contraseña?'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
