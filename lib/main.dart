import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestortareas/providers/tarea_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'login/login_page.dart';
import 'login/home_page.dart';
import 'login/recovery_page.dart';
import 'login/register_page.dart'; // Importa la página de registro
import 'login/styles.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ChangeNotifierProvider(
      create: (context) =>
          TareaProvider(), // Crea una instancia del TareaProvider
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      theme: ThemeData(
        primaryColor: AppTheme.primaryColor,
        scaffoldBackgroundColor: AppTheme.backgroundColor,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/home': (context) => HomePage(),
        '/register': (context) =>
            RegisterPage(), // Define la ruta para el registro
        '/recovery': (context) => RecoveryPage(),
        '/inicio': (context) => HomeScreen()
      },
    );
  }
}
