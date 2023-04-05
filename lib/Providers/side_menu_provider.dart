import 'package:flutter/material.dart';

class SideMenuProvider extends ChangeNotifier {
  //Me ayuda a manejar la animacion del menu.
  static late AnimationController menuController;
  static bool isOpen = false;

  String _currentPage = "";

  String get currentPage => _currentPage;

  //Funcion para cambiar el color del boton del sidebar de la pagina donde estoy parado,
  void setCurrentPageUrl(String routeName) {
    _currentPage = routeName;
    //Esto lo hago debido a que cuando nosotros manejemos esta funcion en dashboardHandler
    //Ese widget todavia no va a estar dibujado 
    //(Lo estamos dibujando en el propio handler, que no termino),
    //Entonces necesitamos un pequeño delay para que termine el handler, y despues volver a redibujar
    //justo cuando acabo el primer redibujado.
    //Redibujar con la nueva ruta --> Esperar delay --> Redibujar el sidebar con el boton seleccionado.
    Future.delayed(Duration(milliseconds: 100), () {
      notifyListeners();
    });
  }

  //begin=-200 debido a que el width del sidebar es de 200, entonces queremos que empiece escondido
  //todo el sidebar a la izquierda (Lo muevo 200 unidades a la izquierda).
  //0 es la posicion original.
  static Animation<double> movement = Tween<double>(begin: -200, end: 0)
      .animate(
          CurvedAnimation(parent: menuController, curve: Curves.easeInOut));
  //0 y 1 son los valores en los que va a variar la opacidad.
  static Animation<double> opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: menuController, curve: Curves.easeInOut));

  static void openMenu() {
    isOpen = true;
    menuController.forward(); //Dispara la animacion.
  }

  static void closeMenu() {
    isOpen = false;
    menuController.reverse(); //Dispara la animacion, pero al reves.
  }

  static void toggleMenu() {
    isOpen ? menuController.reverse() : menuController.forward();
    isOpen = !isOpen;
  }
}
