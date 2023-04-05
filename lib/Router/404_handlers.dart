import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/UI/Views/login_view.dart';
import 'package:admin_dashboard/Router/router.dart';
import 'package:admin_dashboard/UI/Views/view_404.dart';
import '../Providers/auth_provider.dart';
import '../Providers/side_menu_provider.dart';

class Handlers404 {
  static Handler handler404 = Handler(handlerFunc: (context, params) {
  final authProvider = Provider.of<AuthProvider>(context!);
    if (authProvider.authStatus == AuthStatus.notAuthenticated) 
      return const LoginView();
    Provider.of<SideMenuProvider>(context,listen: false)
      .setCurrentPageUrl("/404");
    return const View404();
  });
}