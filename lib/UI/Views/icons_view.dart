import 'package:admin_dashboard/UI/Labels/labels.dart';
import 'package:flutter/material.dart';

import '../Cards/white_card.dart';

class IconsView extends StatelessWidget {
  const IconsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text(
            "Icons View",
            style: CustomLabels.h1,
          ),
          const SizedBox(height: 10),
          Wrap( //El wrap se encarga de mostrar todo si hay suficiente espacio, sino saltar de linea.
            crossAxisAlignment: WrapCrossAlignment.start,
            direction: Axis.horizontal,
            children: const[
              WhiteCard(
                title: "ac_unit_outlined",
                width: 170,
                child:Center(
                  child: Icon(Icons.ac_unit_outlined),
                ),
              ),
              WhiteCard(
                title: "access_alarms_outlined",
                width: 170,
                child:Center(
                  child: Icon(Icons.access_alarms_outlined),
                ),
              ),
              WhiteCard(
                title: "accessible_forward_outlined",
                width: 170,
                child:Center(
                  child: Icon(Icons.accessible_forward_outlined),
                ),
              ),
              WhiteCard(
                title: "dangerous_outlined",
                width: 170,
                child:Center(
                  child: Icon(Icons.dangerous_outlined),
                ),
              ),
              WhiteCard(
                title: "g_translate_outlined",
                width: 170,
                child:Center(
                  child: Icon(Icons.g_translate_outlined),
                ),
              ),
              WhiteCard(
                title: "Icons.gamepad_outlined",
                width: 170,
                child:Center(
                  child: Icon(Icons.gamepad_outlined),
                ),
              ),
              WhiteCard(
                title: "abc_outlined",
                width: 170,
                child:Center(
                  child: Icon(Icons.abc_outlined),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}