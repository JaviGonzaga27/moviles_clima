import 'package:flutter/material.dart';
import '../modelo/clima_modelo.dart';
import '../controlador/clima_controlador.dart';
import 'vista_widget.dart';

class ClimaVista extends StatefulWidget {
  @override
  ClimaVistaState createState() => ClimaVistaState();
}

class ClimaVistaState extends State<ClimaVista> {
  final TextEditingController ciudadc = TextEditingController();
  final ClimaControlador climac = ClimaControlador();
  ClimaModelo? climaModelo;
  bool cargando = false;

  // Define color palette
  static const Color primaryColor = Color(0xFF6B9DFC);
  static const Color accentColor = Color(0xFF4A80F0);
  static const Color backgroundColor = Color(0xFFF3F6FD);
  static const Color textColor = Color(0xFF1D1D1D);
  static const Color secondaryTextColor = Color(0xFF7B7B7B);

  void obtenerClima() async {
    setState(() {
      cargando = true;
    });
    climaModelo = await climac.obtenerClima(ciudadc.text);
    setState(() {
      cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          'Clima App',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                '¿Qué ciudad buscas?',
                style: TextStyle(
                  color: textColor,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  controller: ciudadc,
                  style: TextStyle(color: textColor),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Ingresa el nombre de la ciudad',
                    hintStyle: TextStyle(color: secondaryTextColor),
                    prefixIcon: Icon(Icons.search, color: accentColor),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(color: primaryColor, width: 2),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: obtenerClima,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor, // en lugar de primary
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Buscar',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: Center(
                  child: cargando
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(primaryColor),
                        )
                      : climaModelo != null
                          ? ClimaWidget(
                              ciudad: climaModelo!.ciudad,
                              temperatura: climaModelo!.temperatura,
                              descripcion: climaModelo!.descripcion,
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_queue,
                                  size: 80,
                                  color: secondaryTextColor,
                                ),
                                const SizedBox(height: 15),
                                Text(
                                  'Ingresa una ciudad para ver el clima',
                                  style: TextStyle(
                                    color: secondaryTextColor,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
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
