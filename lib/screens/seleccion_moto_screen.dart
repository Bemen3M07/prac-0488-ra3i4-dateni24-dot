import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/taller_provider.dart';
import 'calculo_autonomia_screen.dart';

class SeleccionMotoScreen extends StatefulWidget {
  const SeleccionMotoScreen({super.key});

  @override
  State<SeleccionMotoScreen> createState() => _SeleccionMotoScreenState();
}

class _SeleccionMotoScreenState extends State<SeleccionMotoScreen> {
  String? _motoSeleccionadaId;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TallerProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Selecciona tu moto'),
       backgroundColor: Colors.white,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.motorcycle, size: 100, color: Color.fromARGB(255, 255, 255, 255)),
            const SizedBox(height: 30),
            const Text(
              'Calculadora de autonomia',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 50),
            DropdownButtonFormField<String>(
              value: _motoSeleccionadaId,
              decoration: const InputDecoration(
                labelText: 'Modelo de la moto',
                border: OutlineInputBorder(),
              ),
              items: provider.motos.map((moto) {
                return DropdownMenuItem(
                  value: moto.marcaModelo,
                  child: Text(moto.marcaModelo),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _motoSeleccionadaId = value;
                });
              },
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                onPressed: _motoSeleccionadaId != null
                    ? () {
                        provider.seleccionarMoto(_motoSeleccionadaId!);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CalculoAutonomiaScreen(),
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: const Text('Continuar'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
