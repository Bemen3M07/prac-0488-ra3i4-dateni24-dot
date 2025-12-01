import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/taller_provider.dart';
import 'screens/seleccion_moto_screen.dart';

void main() {
  runApp(const TallerApp());
}

class TallerApp extends StatelessWidget {
  const TallerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TallerProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Calculadora Autonomia Motos',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color.fromARGB(255, 255, 255, 255)),
        home: const SeleccionMotoScreen(),
      ),
    );
  }
}


