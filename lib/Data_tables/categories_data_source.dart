import 'package:admin_dashboard/Providers/categories_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Models/categoria.dart';
import '../UI/Modals/category_modal.dart';

class CategoriesDTS extends DataTableSource {
  final List<Categoria> categorias;
  final BuildContext context; //Esto es para que se le mande el contexto.

  CategoriesDTS(this.categorias, this.context);
  @override
  DataRow getRow(int index) {
    final categoria = categorias[index];
    return DataRow.byIndex(index: index, cells: [
      //Si tengo 4 columnas en categories_view, en el PaginatedDataTable,
      //entonces tengo que tener 4 DataCell aqui.
      //Distintas posibilidades:
      //DataCell(Text("Cell #1 index: $index"),showEditIcon: true Muestra boton de edicion.
      //DataCell(Text("Cell #1 index: $index"),onTap: ()=>print("hola")),

      DataCell(Text("${categoria.id}")),
      DataCell(Text("${categoria.nombre}")),
      DataCell(Text("${categoria.usuario.nombre}")),
      DataCell(Row(
        children: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    builder: ((context) =>
                        CategoryModal(categoria: categoria)));
              },
              icon: const Icon(Icons.edit_outlined)),
          //Boton borrar categoria
          IconButton(
              onPressed: () {
                final dialog = AlertDialog(
                  title: Text("¿Estas seguro de borrar la categoria?"),
                  content: Text(
                      "Borrar definitivamente la categoria ${categoria.nombre}"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pop(); //Cierra el cuadro de dialogo cuando se presiona una opcion.
                        },
                        child: Text("No")),
                    TextButton(
                        onPressed: () async{
                          await Provider.of<CategoriesProvider>(context,listen: false)
                            .deleteCategory(categoria.id);
                          Navigator.of(context).pop();
                        },
                        child: Text("Si, borrar")),
                  ],
                );
                showDialog(context: context, builder: (context) => dialog);
              },
              icon: Icon(
                Icons.delete_outlined,
                color: Colors.red.withOpacity(0.7),
              )),
        ],
      )),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => categorias.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
