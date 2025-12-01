# Taller de Motos

## Estructura
- **Screen 1**: Aceptar coches (TextField marca/modelo + botón)
- **Screen 2**: Contador pendientes + botón "Reparar Siguiente"
- **Screen 3**: Contador reparados + lista de coches terminados

## Provider
- `TallerProvider`: gestiona coches pendientes y reparados
- Métodos: `aceptarCoche()`, `repararSiguiente()`, `repararCoche()`

## Ejecutar
```powershell
cd "taller_motos"
flutter pub get
flutter run
```
