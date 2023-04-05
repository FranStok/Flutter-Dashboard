import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:admin_dashboard/Providers/auth_provider.dart';
import 'package:admin_dashboard/Providers/login_form_provider.dart';
import 'package:admin_dashboard/UI/Buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/UI/Buttons/link_text.dart';
import 'package:admin_dashboard/Router/router.dart';

import '../Inputs/customs_inputs.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    //Uso este provider para almacenar los datos del login. Es el provider global, en el main.
    final authProvider = Provider.of<AuthProvider>(context);
    return ChangeNotifierProvider(
        //Esto sirve para crear el provider para manejar el form.
        create: (context) => LoginFormProvider(),
        //Utilizo el builder para poder tener acceso al LoginForm Provider,
        //creando un nuevo contexto.
        child: Builder(builder: (context) {
          //Esto va a buscar el provider mas cercano de arriba del contexto,
          //que es create: (context) => LoginFormProvider().
          final loginFormProvider =
              Provider.of<LoginFormProvider>(context, listen: false);
          return Container(
            margin: const EdgeInsets.only(top: 100),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 370),
                child: Form(
                  //Empieza a validar el campo en el momento que arrancamos a escribir.
                  autovalidateMode: AutovalidateMode.always,
                  //La key es la llave del mismo provider, entonces puedo manejar este
                  //form desde los distintos lugares donde tenga acceso al provider.
                  //Desde el provider tengo acceso a todo el estado del formulario.
                  key: loginFormProvider.formKey,
                  child: Column(
                    children: [
                      //Email
                      TextFormField(
                        //onFieldSubmitted me permite mandar el formulario presionando enter.
                        onFieldSubmitted: (value) =>
                            onFormSubmit(loginFormProvider, authProvider),
                        validator: (value) {
                          //Value es el valor que viene del formulario.
                          //Email.Validator es parque del paquete Validate_Email.
                          if (EmailValidator.validate(value ?? ""))
                            return null; //Si regresa null, significa que el campo es valido.
                          else if (value == null || value.isEmpty)
                            return "Ingrese mail";
                          else
                            return "Mail no valido";
                        },
                        style: const TextStyle(color: Colors.white),
                        //Cada vez que la caja de texto cambie, se activa onChanged.
                        //value tiene el valor del nuevo texto.
                        onChanged: (value) => loginFormProvider.email = value,
                        decoration: CustomInputs.AuthInputDecoration(
                            hint: "Ingrese su email",
                            label: "Email",
                            icon: Icons.email_outlined),
                      ),
                      const SizedBox(height: 20),
                      //Password
                      TextFormField(
                        onFieldSubmitted: (value) =>
                            onFormSubmit(loginFormProvider, authProvider),
                        obscureText: true, //Oculta el texto de la contraseña.
                        onChanged: (value) =>
                            loginFormProvider.password = value,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Ingrese su constraseña";
                          if (value.length < 6)
                            return "La contraseña debe ser mayor a 5 caracteres";
                          return null;
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: CustomInputs.AuthInputDecoration(
                            hint: "*********",
                            label: "Contraseña",
                            icon: Icons.password_outlined),
                      ),
                      const SizedBox(height: 20),
                      CustomOutlinedButton(
                          onPressed: () =>
                              onFormSubmit(loginFormProvider, authProvider),
                          text: "Ingresar"),
                      const SizedBox(height: 20),
                      LinkText(
                          text: "Nueva cuenta",
                          onPressed: () {
                            //Siempre que nos movamos dentro de un layout, por ejemplo de
                            //login a register, entonces podemos usar la navegacion interna
                            //Navigator.pushNamed. Ambas rutas son auth/login o auth/register.
                            //Navigator.pushNamed(
                                //context, fluroRouter.registerRoute);
                            //Uso pushReplacementNamed para que RegisterRoute remplace a 
                            //LoginRoute en el stack. Si usamos pushNamed, entonces
                            //no lo remplaza, sino que lo pone en el tope de la pila.
                            Navigator.pushReplacementNamed(
                                context, fluroRouter.registerRoute);    
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

void onFormSubmit(
  LoginFormProvider loginFormProvider, AuthProvider authProvider) {
  bool isValid = loginFormProvider.validateForm();
  if (isValid)
    authProvider.login(loginFormProvider.email, loginFormProvider.password);
}
