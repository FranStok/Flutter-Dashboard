import 'package:admin_dashboard/Providers/auth_provider.dart';
import 'package:admin_dashboard/Providers/side_menu_provider.dart';
import 'package:admin_dashboard/Router/router.dart';
import 'package:admin_dashboard/Services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/UI/Shared/widgets/logo.dart';
import 'package:admin_dashboard/UI/Shared/text_separator.dart';
import 'package:admin_dashboard/UI/Shared/widgets/menu_item.dart';
import 'package:provider/provider.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  void navigateTo(String routeName) {
    //Uso el NavigationService que definimos en Services, ya que tiene la NavigationKey
    //Declarara en el main.
    NavigationService.replaceTo(routeName);
    SideMenuProvider.closeMenu();
  }

  @override
  Widget build(BuildContext context) {
    final sideMenuProvider = Provider.of<SideMenuProvider>(context);

    return Container(
      width: 200,
      height: double.infinity,
      decoration: buildBoxDecoration(),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          const Logo(),
          const SizedBox(height: 50),
          const TextSeparator(text: "main"),
          MenuItem(
              text: "Dashboard",
              icon: Icons.compass_calibration_outlined,
              isActive:
                  sideMenuProvider.currentPage == fluroRouter.dashBoardRoute,
              onPressed: () => navigateTo(fluroRouter.dashBoardRoute)),
          MenuItem(
              text: "Orders",
              icon: Icons.shopping_bag_outlined,
              isActive: false,
              onPressed: () => SideMenuProvider.closeMenu()),
          MenuItem(
              text: "Analytic",
              icon: Icons.show_chart_outlined,
              isActive: false,
              onPressed: () => SideMenuProvider.closeMenu()),
          MenuItem(
              text: "Categories",
              icon: Icons.layers_outlined,
              isActive:sideMenuProvider.currentPage == fluroRouter.categoriesRoute,
              onPressed: () => navigateTo(fluroRouter.categoriesRoute)),
          MenuItem(
              text: "Products",
              icon: Icons.dashboard_outlined,
              isActive: false,
              onPressed: () => SideMenuProvider.closeMenu()),
          MenuItem(
              text: "Discounts",
              icon: Icons.attach_money_outlined,
              isActive: false,
              onPressed: () => SideMenuProvider.closeMenu()),
          MenuItem(
              text: "Users",
              icon: Icons.people_alt_outlined,
              isActive:sideMenuProvider.currentPage == fluroRouter.usersRoute,
              onPressed: () => navigateTo(fluroRouter.usersRoute)),
          const SizedBox(height: 30),
          const TextSeparator(text: "UI Elements"),
          MenuItem(
              text: "Icons",
              icon: Icons.list_alt_outlined,
              isActive: sideMenuProvider.currentPage == fluroRouter.iconsRoute,
              onPressed: () => navigateTo(fluroRouter.iconsRoute)),
          MenuItem(
              text: "Marketing",
              icon: Icons.mark_email_read_outlined,
              isActive: false,
              onPressed: () => SideMenuProvider.closeMenu()),
          MenuItem(
              text: "Campaign",
              icon: Icons.note_add_outlined,
              isActive: false,
              onPressed: () => SideMenuProvider.closeMenu()),
          MenuItem(
              text: "Blank",
              icon: Icons.post_add_outlined,
              isActive: sideMenuProvider.currentPage == fluroRouter.blankRoute,
              onPressed: () => navigateTo(fluroRouter.blankRoute)),
          const SizedBox(height: 50),
          const TextSeparator(text: "exit"),
          MenuItem(
              text: "Log Out",
              icon: Icons.exit_to_app_outlined,
              isActive: false,
              onPressed: () {
                Provider.of<AuthProvider>(context,listen: false).logout();
              }),
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      gradient: LinearGradient(colors: [Color(0xff092044), Color(0xff092043)]),
      boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)]);
}
