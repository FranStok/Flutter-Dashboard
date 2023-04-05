import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class LinkText extends StatefulWidget {
  final String text;
  final Function onPressed;
  const LinkText({super.key, required this.text, required this.onPressed});

  @override
  State<LinkText> createState() => _LinkTextState();
}

class _LinkTextState extends State<LinkText> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:()=>widget.onPressed(),
      child: MouseRegion(
        //Sirve para cambiasr la apariencia del mouse y el texto cuando se pasa por encima.
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Text(
            widget.text,
            style: GoogleFonts.montserratAlternates(
                fontSize: 16,
                color: Color.fromARGB(255, 155, 154, 154),
                decoration: isHover
                    ? TextDecoration.underline
                    : TextDecoration.none //Subrayado del texto.
                ),
          ),
        ),
      ),
    );
  }
}
