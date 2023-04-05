import 'package:admin_dashboard/Providers/auth_provider.dart';
import 'package:admin_dashboard/Providers/register_form_provider.dart';
import 'package:admin_dashboard/Router/router.dart';
import 'package:admin_dashboard/UI/Buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/UI/Buttons/link_text.dart';
import 'package:admin_dashboard/UI/Inputs/customs_inputs.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => RegisterFormProvider(),
        child: Builder(builder: (context) {
          final registerFormProvider =
              Provider.of<RegisterFormProvider>(context, listen: false);
          return Container(
            margin: const EdgeInsets.only(top: 50),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370),
                child: Form(
                  key: registerFormProvider.formKey,
                  child: Column(
                    children: [
                      //Nombre
                      TextFormField(
                        validator: (value) => (value == null || value.isEmpty)
                            ? "Ingrese nombre"
                            : null,
                        onChanged: (value) =>
                            registerFormProvider.nombre = value,
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.AuthInputDecoration(
                            hint: "Ingrese su nombre",
                            label: "Nombre",
                            icon: Icons.supervised_user_circle_sharp),
                      ),
                      const SizedBox(height: 20),
                      //Email
                      TextFormField(
                        validator: (value) {
                          if (EmailValidator.validate(value ?? ""))
                            return null;
                          else if (value == null || value.isEmpty)
                            return "Ingrese mail";
                          else
                            return "Mail no valido";
                        },
                        onChanged: (value) => registerFormProvider.mail = value,
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.AuthInputDecoration(
                            hint: "Ingrese su email",
                            label: "Email",
                            icon: Icons.email_outlined),
                      ),
                      const SizedBox(height: 20),
                      //Password
                      TextFormField(
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Ingrese su constraseña";
                          if (value.length < 6)
                            return "La contraseña debe ser mayor a 5 caracteres";
                          return null;
                        },
                        onChanged: (value) =>
                            registerFormProvider.password = value,
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.AuthInputDecoration(
                            hint: "*********",
                            label: "Contraseña",
                            icon: Icons.password_outlined),
                      ),
                      const SizedBox(height: 20),
                      CustomOutlinedButton(
                          onPressed: () {
                            final validForm =
                                registerFormProvider.validateForm();
                            if (validForm) {
                        final authProvider = Provider.of<AuthProvider>(context, listen: false);
                        authProvider.register(
                          registerFormProvider.mail, 
                          registerFormProvider.password, 
                          registerFormProvider.nombre
                        );
                            }
                          },
                          text: "Crear cuenta"),
                      const SizedBox(height: 20),
                      LinkText(
                          text: "Ir al login",
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, fluroRouter.loginRoute);
                          })
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }
}
