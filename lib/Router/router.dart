import 'package:admin_dashboard/Router/admin_handlers.dart';
import 'package:admin_dashboard/Router/404_handlers.dart';
import 'package:admin_dashboard/Router/dashboard_handlers.dart';
import 'package:admin_dashboard/UI/Views/view_404.dart';
import 'package:fluro/fluro.dart';

class fluroRouter {
  static final FluroRouter router = FluroRouter();

  static String rootRoute = "/";
  //Auth routes:
  static String loginRoute = "/auth/login";
  static String registerRoute = "/auth/register";
  //Dashboard routes
  static String dashBoardRoute = "/dashboard";
  static String iconsRoute = "/dashboard/icons";
  static String categoriesRoute = "/dashboard/categories";
  static String usersRoute = "/dashboard/users";
  static String userRoute = "/dashboard/users/:uid";
  static String blankRoute = "/dashboard/blank";

  static void ConfigureRoutes() {
    router.define(rootRoute, handler: AdminHandlers.login);
    //TransitionType, es para que no haga una transicion rara cuando cambiamos del login al register y visceversa.
    router.define(loginRoute, handler: AdminHandlers.login, transitionType: TransitionType.none);
    router.define(registerRoute, handler: AdminHandlers.register, transitionType: TransitionType.none);

    //Dashboard routes.
    router.define(dashBoardRoute, handler: DashboardHandlers.dashBoard, transitionType: TransitionType.none);
    router.define(iconsRoute, handler: DashboardHandlers.icons, transitionType: TransitionType.none);
    router.define(categoriesRoute, handler: DashboardHandlers.categories, transitionType: TransitionType.none);
    router.define(usersRoute, handler: DashboardHandlers.users, transitionType: TransitionType.none);
    router.define(userRoute, handler: DashboardHandlers.user, transitionType: TransitionType.none);
    router.define(blankRoute, handler: DashboardHandlers.blank, transitionType: TransitionType.none);

    router.notFoundHandler = Handlers404.handler404;
  }
}
