import 'package:admin_dashboard/Providers/categories_provider.dart';
import 'package:admin_dashboard/Services/notification_service.dart';
import 'package:admin_dashboard/UI/Buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/UI/Labels/labels.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Models/categoria.dart';
import '../Inputs/customs_inputs.dart';

class CategoryModal extends StatefulWidget {
  final Categoria? categoria;

  const CategoryModal({super.key, this.categoria});

  @override
  State<CategoryModal> createState() => _CategoryModalState();
}

class _CategoryModalState extends State<CategoryModal> {
  String nombreCat = "";
  String? id;

  @override
  void initState() {
    super.initState();
    id = widget.categoria?.id;
    nombreCat = widget.categoria?.nombre ?? "";
  }

  @override
  Widget build(BuildContext context) {
    final categoriesProvider =
        Provider.of<CategoriesProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(20),
      height: 500,
      width: 300,
      decoration: buildBoxDecoration(),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(widget.categoria?.nombre ?? "Nueva categoria",
                style: CustomLabels.h1.copyWith(color: Colors.white)),
            IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.close_outlined),
              color: Colors.white,
            )
          ]),
          Divider(color: Colors.white.withOpacity(0.3)),
          const SizedBox(height: 20),
          TextFormField(
            initialValue: widget.categoria?.nombre ?? "",
            onChanged: (value) => nombreCat = value,
            decoration: CustomInputs.AuthInputDecoration(
                hint: "Nombre de la categoria",
                label: "Categoria",
                icon: Icons.new_releases_outlined),
            style: const TextStyle(color: Colors.white),
          ),
          Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 30),
            child: CustomOutlinedButton(
                onPressed: () async {
                  try {
                    if (id == null) {
                      await categoriesProvider.newCategory(nombreCat);
                      NotificationService.showSnackbar("$nombreCat creada!");
                    } else {
                      await categoriesProvider.updateCategory(id!, nombreCat);
                      NotificationService.showSnackbar(
                          "$nombreCat actualizada!");
                    }
                    Navigator.of(context).pop();
                  } catch (e) {
                      Navigator.of(context).pop();
                      NotificationService.showSnackbarError(
                        "No se pudo guardar o actualizar la categoria");
                  }
                },
                isWhite: true,
                text: "Guardar",
                color: Colors.white),
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => const BoxDecoration(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20), topRight: Radius.circular(20)),
      color: Color(0xff0f2041),
      boxShadow: [BoxShadow(color: Colors.black26)]);
}
