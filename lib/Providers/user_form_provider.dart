import 'dart:typed_data';

import 'package:admin_dashboard/Models/usuario.dart';
import 'package:flutter/material.dart';

import '../Api/cafeApi.dart';

class UserFormProvider extends ChangeNotifier {
  Usuario? user;
  late GlobalKey<FormState> formKey;

  bool _validForm() {
    return formKey.currentState!.validate();
  }

  Future updateUser() async {
    if (!_validForm()) return false;

    final data = {
      "nombre": user!.nombre,
      "correo": user!.correo,
    };

    try {
      final response = await CafeApi.put("/usuarios/${user!.uid}", data);
      print(response);
      return true;
    } catch (e) {
      print("Error en el update $e");
      return false;
    }
  }

  //Uint8List bytes viene de los bytes de la imagen con file_picker, Mirar user_view linea 148.
  Future<Usuario> uploadImage(String path, Uint8List bytes) async {
    try {
      final response = await CafeApi.uploadFile(path, bytes);
      user = Usuario.fromJson(response);
      notifyListeners();
      return user!;
    } catch (e) {
      print(e);
      throw "Error en el user from provider";
    }
  }
}
