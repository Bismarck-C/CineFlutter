import 'package:cineapp/navegacion/navegacion.dart';
import 'package:flutter/material.dart';

class SobreScreen extends StatelessWidget {
  static const routeName = '/sobre';

  const SobreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> desarrolladores = [
      {
        'nombre': 'Bismarck Victor',
        'imagen': 'assets/images/ima1.jpeg',
        'descripcion': 'Desarrollador de software.'
      },
      {
        'nombre': 'Dylan Mejia',
        'imagen': 'assets/images/ima2.jpeg',
        'descripcion': 'Desarrollador de software.'
      },
    ];

    return Navegador(
      selectedIndex: 3, 
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Sobre la App', style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),),
          backgroundColor: Colors.black,
          toolbarHeight: 86.2,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(25),
                bottomLeft: Radius.circular(25)),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white,
          )
        ),
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: desarrolladores.length,
                  itemBuilder: (ctx, index) {
                    final dev = desarrolladores[index];
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 70,
                          backgroundImage: AssetImage(dev['imagen']!),
                        ),
                        const SizedBox(height:10),
                        Text(
                          dev['nombre']!,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          dev['descripcion']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 16,
                            color: Color.fromARGB(255, 99, 98, 98),
                          ),
                        ),
                        const SizedBox(height: 100),
                      ],
                    );
                  },
                ),
              ),
              const Divider(height: 1, color: Colors.white),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(
                  child: Text(
                    'Versión de la aplicación: 1.0',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
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
