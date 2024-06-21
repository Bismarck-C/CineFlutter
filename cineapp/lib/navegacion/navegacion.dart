import 'package:flutter/material.dart';

class Navegador extends StatefulWidget {
  final Widget child;
  final int selectedIndex;

  const Navegador({super.key, required this.child, required this.selectedIndex});

  @override
 NavegadorState createState() => NavegadorState();
}

class NavegadorState extends State<Navegador> {
  void _onItemTapped(int index) {
    setState(() {
      // La lógica de navegación basada en el índice seleccionado
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/categorias');
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, '/sobre');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorías',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Sobre la App',
          ),
        ],
        currentIndex: widget.selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: const Color.fromARGB(255, 156, 154, 154),
        onTap: _onItemTapped,
      ),
    );
  }
}
