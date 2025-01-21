import 'package:flutter/material.dart';

class ClimaWidget extends StatelessWidget {
  final String ciudad;
  final double temperatura;
  final String descripcion;

  // Definimos colores personalizados
  static const Color cardColor1 = Color(0xFF6B9DFC);
  static const Color cardColor2 = Color(0xFF4A80F0);
  static const Color textColor = Colors.white;

  const ClimaWidget({
    Key? key,
    required this.ciudad,
    required this.temperatura,
    required this.descripcion,
  }) : super(key: key);

  // Método para seleccionar el icono según la descripción del clima
  IconData _getWeatherIcon() {
    final desc = descripcion.toLowerCase();
    if (desc.contains('lluvia')) return Icons.water_drop;
    if (desc.contains('nube')) return Icons.cloud;
    if (desc.contains('tormenta')) return Icons.thunderstorm;
    if (desc.contains('nieve')) return Icons.ac_unit;
    return Icons.wb_sunny;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Card(
        elevation: 8,
        shadowColor: cardColor1.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            gradient: LinearGradient(
              colors: [cardColor1, cardColor2],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                ciudad,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(
                  _getWeatherIcon(),
                  color: textColor,
                  size: 70,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                '${temperatura.toStringAsFixed(1)}°',
                style: const TextStyle(
                  color: textColor,
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Text(
                  descripcion,
                  style: const TextStyle(
                    color: textColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
