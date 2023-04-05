// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class CustomOutlinedButton extends StatelessWidget {
  final Function onPressed;
  final String text;
  final Color color;
  final bool isFilled;
  //Esto es para cuando uso este boton en las categorias y quiero que el texto sea blanco.
  final bool isWhite;
  const CustomOutlinedButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.color = Colors.blue,
      this.isFilled = false, 
      this.isWhite=false});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(//Le da el border radius al boton.
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50))),
          side: MaterialStateProperty.all(//Le da al border un color.
              BorderSide(color: this.color)),
          backgroundColor: MaterialStateProperty.all(
              //Cambia el color dependiendo de isFilled.
              isFilled ? color.withOpacity(0.3) : Colors.transparent)),
      onPressed: () => onPressed(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: isWhite ? Colors.white :Colors.blue),
        ),
      ),
    );
  }
}
