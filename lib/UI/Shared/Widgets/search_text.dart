import 'package:admin_dashboard/UI/Inputs/customs_inputs.dart';
import 'package:flutter/material.dart';

class SearchText extends StatelessWidget {
  const SearchText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: buildBoxDecotraion(),
      child: TextField(
        decoration: CustomInputs.searchInputDecoration(hint: "Search", icon: Icons.search_outlined),
      ),
    );
  }

  BoxDecoration buildBoxDecotraion() => BoxDecoration(
    borderRadius: BorderRadius.circular(50),
    color: Colors.grey.withOpacity(0.35)
  );
}