import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';

class NotificationIndicator extends StatelessWidget {
  const NotificationIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned(
            left: 2,
            child: Container(
              width: 5,
              height: 5,
              decoration: buildDecoration(),
            ),
          ),
          const Icon(Icons.notifications_none_outlined,color: Colors.grey),
        ],
      ),
    );
  }

  BoxDecoration buildDecoration() => BoxDecoration(
    color: Colors.red,
    borderRadius: BorderRadius.circular(100)
  );
}