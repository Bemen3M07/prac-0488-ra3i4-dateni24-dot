class Moto {
  final String marcaModelo;
  final double fuelTankLiters; 
  final double consumptionL100; 
   
  Moto({
    required this.marcaModelo,
    required this.fuelTankLiters,
    required this.consumptionL100,
  });

  double calcularKilometrosRestantes(int kmInici, int kmActual) {
    final kmRecorreguts = kmActual - kmInici;
    final litresGastats = (kmRecorreguts / 100) * consumptionL100;
    final autonomia = 100 / consumptionL100;
    final litresRestants = fuelTankLiters - litresGastats;
    return litresRestants * autonomia;
  }
  String getDescripcionCompleta() {
    return 'Model: $marcaModelo, Dipòsit: ${fuelTankLiters.toStringAsFixed(1)} L, Consum: ${consumptionL100.toStringAsFixed(1)} L/100km';
  }
  String getDescripcionCorta() {
    return '$marcaModelo - ${ (100 / consumptionL100).toStringAsFixed(1)} km/l - ${fuelTankLiters.toStringAsFixed(1)} L';
  }
}
