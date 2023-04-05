import 'package:flutter/material.dart';

import 'auth_provider.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String email = "";
  String password = "";


  bool validateForm() {
    //El formKey, es el mismo formKey que el LoginView.
    //Esto dispara el metodo validate de cada TextFormField.
    //Devuelve true si todos los validate dan bien.
    if (formKey.currentState!.validate()) {
      return true;
    }
    return false;
  }
}
