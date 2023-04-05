import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String nombre = "";
  String mail = "";
  String password = "";
  validateForm() {
    if (formKey.currentState!.validate()) {
      print("$nombre $mail $password");
      return true;
    } else
        return false;
  }
}
