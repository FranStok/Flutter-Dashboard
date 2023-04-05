import 'package:admin_dashboard/Router/router.dart';
import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Providers/inport_providers.dart';

import 'package:admin_dashboard/Services/inport_services.dart';

import 'package:admin_dashboard/UI/Labels/labels.dart';
import '../../Models/usuario.dart';
import '../Cards/white_card.dart';
import '../Inputs/customs_inputs.dart';

class UserView extends StatefulWidget {
  final String UID;
  const UserView({super.key, required this.UID});

  @override
  State<UserView> createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  Usuario? user;

  @override
  void initState() {
    super.initState();
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final userFormProvider =
        Provider.of<UserFormProvider>(context, listen: false);
    //Una vez que tenemos el usuario, eliminamos el simbolo de carga del build.
    //Este metodo es un future.
    //userDB es el valor que retorna getUserById.
    usersProvider.getUserById(widget.UID).then((userDB) {
      if (userDB != null) {
        userFormProvider.user = userDB;
        userFormProvider.formKey = GlobalKey<FormState>();
        setState(() => user = userDB);
      } else {
        NavigationService.replaceTo(fluroRouter.usersRoute);
      }
    });
  }

  //Funcion que elimina se llama cuando se elimina del widget tree, a este widget (userView).
  //Se lo llama cuando el widget no va a ser construido de vuelta. Purga el state.
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text(
            "User View",
            style: CustomLabels.h1,
          ),
          const SizedBox(height: 10),
          if (user == null)
            WhiteCard(
                child: Container(
              alignment: Alignment.center,
              height: 300,
              child: const CircularProgressIndicator(),
            ))
          else
            const _UserViewBody()
        ],
      ),
    );
  }
}

class _UserViewBody extends StatelessWidget {
  const _UserViewBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Table(
      //Establece el width de las columnas especificadas.
      columnWidths: const {
        0: FixedColumnWidth(200),
      },
      children: const [
        TableRow(children: [
          //Avatar
          _AvatarContainer(),
          //Form de actualizacion
          _UserViewForm()
        ])
      ],
    );
  }
}

class _AvatarContainer extends StatelessWidget {
  const _AvatarContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final image= (userFormProvider.user!.img==null)
      ? Image(image: AssetImage("no-image.jpg"))
      : FadeInImage.assetNetwork(placeholder: "loader.gif", image: userFormProvider.user!.img!,);
    return WhiteCard(
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Profile",
              style: CustomLabels.h2,
            ),
            const SizedBox(height: 20),
            Container(
              width: 150,
              height: 160,
              child: Stack(
                children: [
                  ClipOval(
                    child: image
                  ),
                  Positioned(
                    bottom: 5,
                    right: 5,
                    child: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Colors.white, width: 5)),
                      child: FloatingActionButton(
                        backgroundColor: Colors.indigo,
                        child: Icon(Icons.camera_alt_outlined),
                        onPressed: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(
                                  type: FileType
                                      .custom, //Sino no pongo esto no anda.
                                  allowedExtensions: ["jpg", "png", "jpeg"],
                                  allowMultiple: false);
                          if (result != null) {
                            NotificationService.showBusyIndicator(context);
                            //PlatformFile file = result.files.first;
                            final response = await userFormProvider.uploadImage(
                                "/uploads/usuarios/${userFormProvider.user!.uid}",
                                result.files.first.bytes!);
                            Navigator.of(context).pop(); //Remueve el BusyIndicator.
                            Provider.of<UsersProvider>(context, listen: false)
                              .refreshUser(userFormProvider.user);
                          } else {
                            // User canceled the picker
                          }
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              userFormProvider.user?.nombre ?? "",
              style: TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}

class _UserViewForm extends StatelessWidget {
  const _UserViewForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user;
    return WhiteCard(
        title: "Informacion general",
        child: Form(
          key: userFormProvider.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              TextFormField(
                initialValue: user?.nombre,
                decoration: CustomInputs.formInputDecoration(
                    hint: "Nombre de usuario",
                    label: "Nombre",
                    icon: Icons.supervised_user_circle_outlined),
                onChanged: (value) {
                  user?.nombre = value;
                },
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return "Ingrese un nombre";
                  if (value.length < 2) return "Nombre muy corto";
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                initialValue: user?.correo,
                decoration: CustomInputs.formInputDecoration(
                    hint: "Correo del usuario",
                    label: "Correo",
                    icon: Icons.mark_email_read_outlined),
                onChanged: (value) {
                  user?.correo = value;
                },
                validator: (value) {
                  if (EmailValidator.validate(value ?? "")) return null;
                  if (value == null || value.isEmpty) return "Ingrese mail";
                  return "Mail no valido";
                },
              ),
              const SizedBox(height: 20),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 110),
                child: ElevatedButton(
                    onPressed: () async {
                      final saved = await userFormProvider.updateUser();
                      if (saved) {
                        NotificationService.showSnackbar(
                            "Usuario actualizado!");
                        Provider.of<UsersProvider>(context, listen: false)
                            .refreshUser(user);
                      } else
                        NotificationService.showSnackbarError(
                            "El usuario no se pudo actualizar");
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent)),
                    child: Row(
                      children: const [
                        Icon(Icons.save_outlined),
                        Text("Guardar")
                      ],
                    )),
              )
            ],
          ),
        ));
  }
}
