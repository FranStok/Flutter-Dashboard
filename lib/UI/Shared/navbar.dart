import 'package:admin_dashboard/Providers/side_menu_provider.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/UI/Shared/Widgets/search_text.dart';
import 'Widgets/navbar_avatar.dart';
import 'Widgets/notification_Indicator.dart';

class Navbar extends StatelessWidget {
  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: 50,
      decoration: buildBoxDecoration(),
      child: Row(children: [
        if(size.width<=700)
          IconButton(onPressed: ()=>SideMenuProvider.openMenu(), icon: Icon(Icons.menu_outlined)),
        const SizedBox(width: 10),
        if(size.width>380)
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 250),
            child: const SearchText(),
          ),
        const Spacer(),
        const NotificationIndicator(),
        SizedBox(width: 10),
        const NavbarAvatar(),
        SizedBox(width: 10),
      ]),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      color: Colors.white,
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)]);
}
