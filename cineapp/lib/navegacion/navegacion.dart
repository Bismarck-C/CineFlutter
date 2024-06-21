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
      if (index == 0) {
        Navigator.pushReplacementNamed(context, '/');
      } else if (index == 1) {
        Navigator.pushReplacementNamed(context, '/categorias');
      } else if (index == 2) {
        Navigator.pushReplacementNamed(context, '/favoritas');
      } else {
        Navigator.pushReplacementNamed(context, '/sobre');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorías',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outlined),
            label: 'Favoritas',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Sobre la App',
            backgroundColor: Colors.black,
          ),
        ],
        currentIndex: widget.selectedIndex,
        selectedItemColor: Colors.white, 
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
