import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class BackgroundTwitter extends StatelessWidget {
  const BackgroundTwitter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.blue, Si trabajamos con decoration, NO se puede usar color.
      decoration: buildBoxDecoration(),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 400),
        child: const Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Image(
              image: AssetImage("twitter-white-logo.png"),
              width: 400,
            ),
          ),
        ),
      ),
    );
  }

  //Metodo para poner la imagen de twitter y manejar la decoracion.
  BoxDecoration buildBoxDecoration() {
    return const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("twitter-bg.png"),
          fit: BoxFit.cover
        )
      );
  }
}
