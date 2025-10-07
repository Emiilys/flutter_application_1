import 'package:flutter/material.dart';
import 'loginpage.dart'; // Importe a tela de login

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EMC - Emergency Center!',
      theme: ThemeData(
        primarySwatch: Colors.green, // Tema verde para combinar com o app
        useMaterial3: true,
      ),
      home: const LoginPage(), // Inicia com a tela de login
      debugShowCheckedModeBanner: false, // Remove a faixa de debug
    );
  }
}