import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';
import 'package:admin_dashboard/UI/Views/login_view.dart';
import 'package:admin_dashboard/UI/Views/register_view.dart';
import '../Providers/auth_provider.dart';
import '../UI/Views/dashboard_view.dart';

class AdminHandlers {
  static Handler login = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return const LoginView();
    return DashboardView();
  });
  static Handler register = Handler(handlerFunc: (context, params) {
    final authProvider = Provider.of<AuthProvider>(context!);
    if (authProvider.authStatus == AuthStatus.notAuthenticated)
      return const RegisterView();
    return DashboardView();
  });
}
