import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/Providers/inport_providers.dart';

import 'package:admin_dashboard/Api/cafeApi.dart';

import 'Services/inport_services.dart';

import 'package:admin_dashboard/Router/router.dart';

import 'package:admin_dashboard/UI/Layouts/Dashboard/dashboard_layout.dart';
import 'package:admin_dashboard/UI/Layouts/splash/splash_layout.dart';
import 'package:admin_dashboard/UI/Layouts/Auth/auth_layout.dart';


void main() async {
  //Configura el LocalStorage Es por esta funcion que el main es async, ya que debemos
  //esperar por el getIntance dentro de configurePrefs().
  await LocalStorage.configurePrefs();
  CafeApi.configureDio();
  fluroRouter.ConfigureRoutes();
  runApp(AppState()); //AppState crea los providers, y despues crea MyApp.
}

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //Lazy=true inicializa el provider cuando se necesite, es el default.
        //False lo inicializa al instante:
        //Comienza el proceso de autentificacion automaticamente cuando se crea el provider.
        ChangeNotifierProvider(
            lazy: false, create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => SideMenuProvider()),
        ChangeNotifierProvider(create: (context) => CategoriesProvider()),
        ChangeNotifierProvider(create: (context) => UsersProvider()),
        ChangeNotifierProvider(create: (context) => UserFormProvider()),
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: fluroRouter.router.generator,
      //Es lo que permite navegar los layouts. Ya que la navegacion interna la
      //hago con push named. (Mirar login_view linea 97)
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey:
          NotificationService.messagerKey, //Sirve para crear los Snackbar.
      title: 'Admin Dashboard',
      initialRoute: fluroRouter.rootRoute,
      //Si la ruta es diferente, entonces el child es diferente.
      //Es decir, si la ruta es /login, entonces el handler va a devolver el LoginView(),
      //que se transforma en el child.
      builder: (context, child) {
        final authProvider = Provider.of<AuthProvider>(context);
        if (authProvider.authStatus == AuthStatus.checking)
          return SplashLayout();
        if (authProvider.authStatus == AuthStatus.notAuthenticated)
          return AuthLayout(child: child!);
        return DashboardLayout(child: child!);
      },
      //Esto lo hago para poner el color del scroll en blanco
      theme: ThemeData.light().copyWith(
          scrollbarTheme: const ScrollbarThemeData().copyWith(
              thumbColor: const MaterialStatePropertyAll(Colors.white))),
    );
  }
}
