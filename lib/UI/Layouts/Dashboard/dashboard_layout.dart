import 'package:admin_dashboard/Providers/side_menu_provider.dart';
import 'package:flutter/material.dart';

import '../../Shared/sidebar.dart';
import 'package:admin_dashboard/UI/shared/navbar.dart';

class DashboardLayout extends StatefulWidget {
  final Widget child;

  const DashboardLayout({super.key, required this.child});

  @override
  State<DashboardLayout> createState() => _DashboardLayoutState();
}

//SingleTickerProviderStateMixin es para poder hacer la linea SideMenuProvider.menuController=AnimationController(vsync: this)
class _DashboardLayoutState extends State<DashboardLayout>
    with SingleTickerProviderStateMixin {

  //Inicializo el menuCotroller del SideMenuProvider.
  @override
  void initState() {
    super.initState();

    SideMenuProvider.menuController = 
      AnimationController(vsync: this,duration: const Duration(milliseconds: 300));
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 220, 225, 226),
        body: Stack(
          children: [
            Row(
              children: [
                //Esto depende de si es >=700px. Como el SideBar esta siempre, lo pongo en el layout.
                //Si es >=700 entonces lo muestro, sino lo muestro fuera de la columna
                //Mas abajo en el stack.
                if (size.width >= 700) 
                  const Sidebar(),
                Expanded(
                  child: Column(
                    children: [
                      const Navbar(),
                      //View
                      Expanded(
                        child: widget.child
                      ),
                    ],
                  ),
                )
              ],
            ),
            //Aqui muestro el mismo Sidebar de arriba, pero como tenemos un width <700, entonces
            //necesito mostrarlo en el tope del stack, para que no ocupe espacio
            //ya que de esta manera se superpone.
            if (size.width < 700)
              AnimatedBuilder(
                  animation: SideMenuProvider.menuController,
                  builder: (context, _) => Stack(
                        children: [
                          if(SideMenuProvider.isOpen)
                          Opacity(
                              //Idem con el offset mas abajo, pero con el valor de opacidad,
                              //de 0 a 1. Cada vez que abrimos el sidebar, el background se oscurece.
                              //Esto sirve para que cada vez que abrimos el menu con width <700,
                              //podemos cerrarlo haciendo click fuera del menu en cualquier lado.
                              //O tambien cuando hacemos click en una opcion del sidebar, entonces
                              //se activa la animacion, y la opacidad pasa de 1 a 0.
                              opacity: SideMenuProvider.opacity.value,
                              child: GestureDetector(
                                onTap: ()=>SideMenuProvider.closeMenu(),
                                child: Container(
                                  width: size.width,
                                  height: size.height,
                                  color: Colors.black26,
                                ),
                              ),
                            ),
                          //Offset juega con las cordenadas X, e Y.
                          //Offset(SideMenuProvider.movement.value) va de -200 a 0,
                          //(Mirar SideMenuProvider.movement) y luego el 0 es el valor de Y, que no se va a mover.
                          //Mueve el Sidevar de una posicion a otra.
                          Transform.translate(
                            offset: Offset(SideMenuProvider.movement.value,0),
                            child: const Sidebar(),
                          ),
                        ],
                      ))
          ],
        ));
  }
}
