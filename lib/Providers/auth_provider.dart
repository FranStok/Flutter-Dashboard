import 'package:admin_dashboard/Api/cafeApi.dart';
import 'package:admin_dashboard/Router/router.dart';
import 'package:admin_dashboard/Services/local_storage.dart';
import 'package:admin_dashboard/Services/navigation_service.dart';
import 'package:admin_dashboard/Services/notification_service.dart';
import 'package:flutter/material.dart';

import '../Models/Http/auth_response.dart';
import '../Models/usuario.dart';

enum AuthStatus {
  checking,
  authenticated,
  notAuthenticated,
}

class AuthProvider extends ChangeNotifier {
  AuthStatus authStatus = AuthStatus.checking;
  Usuario? user; //Este user tiene toda la informacion del usuario actual.

  AuthProvider() {
    isAuthenticated(); //Llamo en el constructor, al metodo.
  }

  login(String email, String password) {
    /* //Parte del login de antes del backend.
    // //TODO peticion http´
    // _token = "ddddawdadawdawdawdawd.dwadadad";
    // LocalStorage.prefs.setString("token", _token!);
    // print("Almacenar JWT: ${LocalStorage.prefs.getString("token")}");

    // authStatus = AuthStatus.authenticated;
    // notifyListeners();
    // //Se puede hacer asi, pero debido a que ahora voy a usar el navigationService, no lo hago.
    // //isAuthenticated();
    // NavigationService.replaceTo(
    //     fluroRouter.dashBoardRoute); //Navego al dashboard.*/
    final data = {"correo": email, "password": password};
    CafeApi.post("/auth/login", data).then((json) {
      print(json);
      final authResponse = AuthResponse.fromJson(json);
      this.user = authResponse.usuario;

      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString("token", authResponse.token);
      NavigationService.replaceTo(fluroRouter.dashBoardRoute);
      CafeApi.configureDio();
      notifyListeners(); //Tengo un usuario y authStatus cambio, asi que tengo que notificar.
    }).catchError((e) {
      NotificationService.showSnackbarError("$e. Error al inciar sesion");
    });
  }

  register(String email, String password, String name) {
    final data = {"nombre": name, "correo": email, "password": password};

    // /usuarios sale de postman, en la parte de crear usuario, es el path.
    // Aqui es donde invoco al metodo post de cafeApi.
    CafeApi.post("/usuarios", data).then((json) {
      print(json);
      final authResponse = AuthResponse.fromJson(json);
      this.user = authResponse
          .usuario; //Aca se le asigna la informacion del usuario actual.

      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString("token", authResponse.token);
      NavigationService.replaceTo(fluroRouter.dashBoardRoute);
      CafeApi.configureDio();
      notifyListeners(); //Tengo un usuario y authStatus cambio, asi que tengo que notificar.
    }).catchError((e) {
      NotificationService.showSnackbarError("$e. Mail");
    });

    //Esta porcion de codigo es previa al montado del backend, y funcionaba para simular guardar
    //Los datos del ingreso, guardando el token en el local storage.
    // authStatus = AuthStatus.authenticated;
    // LocalStorage.prefs.setString("token", _token!);
    // NavigationService.replaceTo(
    // fluroRouter.dashBoardRoute); //Navego al dashboard.
    // notifyListeners();
  }

  //Este metodo nos sirve para saber si el usuario esta autenticado o no.
  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString("token");
    if (token == null) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    try {
      //Endpoint renovar token
      final response = await CafeApi.httpGet("/auth");
      final authResponse = AuthResponse.fromJson(response);
      this.user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
    } catch (e) {
      print(e);
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }

    //Esto es de antes del back.
    // await Future.delayed(
    //     const Duration(milliseconds: 1000)); //Este tiempo simula una query.
    // authStatus = AuthStatus.authenticated;
    // notifyListeners();
    // return true;
  }

  logout() {
    LocalStorage.prefs.remove("token"); //Borra el token de local storage
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}
