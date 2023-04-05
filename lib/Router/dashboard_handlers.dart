import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/Router/router.dart';
import '../Providers/auth_provider.dart';
import '../Providers/side_menu_provider.dart';

import 'package:admin_dashboard/UI/Views/login_view.dart';

import '../UI/Views/blank_view.dart';
import '../UI/Views/categories_view.dart';
import '../UI/Views/dashboard_view.dart';
import '../UI/Views/icons_view.dart';
import '../UI/Views/user_view.dart';
import '../UI/Views/users_view.dart';

class DashboardHandlers {
  static Handler dashBoard = Handler(handlerFunc: (context, params) {
    //Esta linea llama a la funcion del provider SideMenuProvider para cambiar la ruta actual del
    //provider. Mirar la implementacion de la funcion para mas documentacion.
    //Si no usamos el Future.delay en esta funcion, entonces estas llamando a redibujar, antes
    //del return del propio handler, es decir, antes de dibujar, estas redibujando.
    //Eso es un error
    Provider.of<SideMenuProvider>(context!)
        .setCurrentPageUrl(fluroRouter.dashBoardRoute);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      return const DashboardView();
    }
    return const LoginView();
  });
  static Handler icons = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!)
        .setCurrentPageUrl(fluroRouter.iconsRoute);
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.authStatus == AuthStatus.authenticated)
      return const IconsView();
    return const LoginView();
  });
  static Handler categories = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!)
        .setCurrentPageUrl(fluroRouter.categoriesRoute);
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.authStatus == AuthStatus.authenticated)
      return const CategoriesView();
    return const LoginView();
  });
  static Handler blank = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!)
        .setCurrentPageUrl(fluroRouter.blankRoute);
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.authStatus == AuthStatus.authenticated)
      return const BlankView();
    return const LoginView();
  });
  static Handler users = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!)
        .setCurrentPageUrl(fluroRouter.usersRoute);
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.authStatus == AuthStatus.authenticated)
      return const UsersView();
    return const LoginView();
  });
  static Handler user = Handler(handlerFunc: (context, params) {
    Provider.of<SideMenuProvider>(context!)
        .setCurrentPageUrl(fluroRouter.userRoute);
    final authProvider = Provider.of<AuthProvider>(context);
    if (authProvider.authStatus == AuthStatus.authenticated) {
      if (params["uid"]?.first != null) {
        return UserView(UID: params["uid"]!.first);
      }
      return UsersView();
    }
    return const LoginView();
  });
}
