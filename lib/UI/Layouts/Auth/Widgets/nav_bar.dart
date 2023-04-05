import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

import '../../../Buttons/link_text.dart';

class NavBar extends StatelessWidget {
  const NavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      //Mirar auth_layout en la parte de _DesktopBody para entender mejor esta linea de abajo.
      height: size.width>1000 ? size.height*0.07 : null, //Asigno el 5% restante del viewport. El 95% lo tiene _desktopBody
      color: Colors.black,
      child: Wrap(
        alignment: WrapAlignment.center,
        children: [
          LinkText(text: "about",onPressed: ()=>print("Hola")),
          LinkText(text: "Help Center",onPressed: ()=>print("Hola")),
          LinkText(text: "Terms of Service",onPressed: ()=>print("Hola")),
          LinkText(text: "Privacy Policy",onPressed: ()=>print("Hola")),
          LinkText(text: "Cookie Policy",onPressed: ()=>print("Hola")),
          LinkText(text: "Ads info",onPressed: ()=>print("Hola")),
          LinkText(text: "Blog",onPressed: ()=>print("Hola")),
          LinkText(text: "Status",onPressed: ()=>print("Hola")),
          LinkText(text: "Careers",onPressed: ()=>print("Hola")),
          LinkText(text: "Brand Resources",onPressed: ()=>print("Hola")),
          LinkText(text: "Advertising",onPressed: ()=>print("Hola")),
          LinkText(text: "Marketing",onPressed: ()=>print("Hola")),
        ],
      ),
    );
  }
}
