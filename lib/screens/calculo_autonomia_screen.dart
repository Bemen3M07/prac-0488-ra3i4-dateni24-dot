import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/taller_provider.dart';

class CalculoAutonomiaScreen extends StatefulWidget {
  const CalculoAutonomiaScreen({super.key});

  @override
  State<CalculoAutonomiaScreen> createState() => _CalculoAutonomiaScreenState();
}

class _CalculoAutonomiaScreenState extends State<CalculoAutonomiaScreen> {
  final _kmIniciController = TextEditingController();
  final _kmActualController = TextEditingController();
  double? _kmRestantes;

  @override
  void dispose() {
    _kmIniciController.dispose();
    _kmActualController.dispose();
    super.dispose();
  }

  void _calcularAutonomia(BuildContext context) {
    final provider = context.read<TallerProvider>();
    final moto = provider.motoSeleccionada;

    if (moto != null) {
      final kmInici = int.tryParse(_kmIniciController.text) ?? 0;
      final kmActual = int.tryParse(_kmActualController.text) ?? 0;

      if (kmActual > kmInici) {
        setState(() {
          _kmRestantes = moto.calcularKilometrosRestantes(kmInici, kmActual);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tienes que tener mas kilometros que al repostar'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<TallerProvider>();
    final moto = provider.motoSeleccionada;

    if (moto == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('No hay moto seleccionada.'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculo de autonomia'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.motorcycle,
                          size: 40,
                          color: Color.fromARGB(255, 255, 255, 255),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            moto.marcaModelo,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Autonomia de la moto',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${(100 / moto.consumptionL100).toStringAsFixed(1)} km/L',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Deposito de la moto',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              '${moto.fuelTankLiters.toStringAsFixed(1)} L',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Introduce los datos de la moto',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _kmIniciController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Km cuando la llenaste.',

                suffixText: 'km',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _kmActualController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Km actuales de la moto',

                suffixText: 'km',
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton.icon(
                onPressed: () => _calcularAutonomia(context),
                label: const Text('Calcular autonomia'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                  foregroundColor: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (_kmRestantes != null) ...[
              const SizedBox(height: 32),
              Card(
                color: Colors.white,
                elevation: 6,
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const Text(
                        'Aun Puedes hacer:',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${_kmRestantes!.toStringAsFixed(1)} km',
                        style: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
