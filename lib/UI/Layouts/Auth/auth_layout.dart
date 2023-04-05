import 'package:admin_dashboard/UI/Layouts/Auth/Widgets/background_twitter.dart';
import 'package:admin_dashboard/UI/Layouts/Auth/Widgets/custom_title.dart';
import 'package:admin_dashboard/UI/Layouts/Auth/Widgets/nav_bar.dart';
import 'package:flutter/material.dart';

class AuthLayout extends StatelessWidget {

  final Widget child;
  const AuthLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Scrollbar( //Este widget habilita la barra scrolleadora.
        child: ListView(
        children: [
          //Desktop
          (size.width>1000)
            ?_DesktopBody(child: this.child,)
          //Mobile
            :_MobileBody(child: this.child),
          //NavBar
          const NavBar()
        ],
          ),
      ));
  }
}

class _DesktopBody extends StatelessWidget {
  final Widget child;
  const _DesktopBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    //size tiene informacion importante del ListView de arriba
    //Ya que los hijos de ListView deben tener un tamaño especifico.
    final size = MediaQuery.of(context).size;
    return Container(
      //width y height obligatorios cuando estamos trabajando con ListView.
      width: size.width,
      //De esta manera, el size del _DesktopBody es del 95% de la totalidad del viewport.
      //De esta manera, queda espacio en la pagina para el nav_bar, que a su vez le asigno el
      //5% restante que le falta, para que entre justo en la pagina.
      height: size.height * 0.93,
      color: Colors.black,
      child: Row(
        children: [
          //Twitter background
          //El expanded lo hace flexible, es decir, que se adapte al tamaño.
          const Expanded(child: BackgroundTwitter()),
          //View Container
          Container(
              width: 600,
              height: double.infinity, //Todo el ancho posible.
              color: Colors.black,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const CustomTitle(),
                  const SizedBox(height: 50),
                  Expanded(child: child)
                ],
              )
          )
        ],
      ),
    );
  }
}

class _MobileBody extends StatelessWidget {
  final Widget child;
  const _MobileBody({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      color: Colors.black,
      child: Column(
        children: [
           Container(
            color: Colors.black,
            child: Column(
              children:[
                const SizedBox(height: 20),
                const CustomTitle(),
                Container(
                  width: double.infinity,
                  height: 420,
                  child: child,
                ),
                Container(
                  width: double.infinity,
                  height: 400,
                  child: const BackgroundTwitter(),
                )
              ],
            )
          ),
        ],
      ),
    );
  }
}
