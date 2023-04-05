import 'package:admin_dashboard/UI/Modals/category_modal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/UI/Buttons/custom_icon_button.dart';
import 'package:admin_dashboard/UI/Labels/labels.dart';

import '../../Providers/categories_provider.dart';

import '../../Data_tables/categories_data_source.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  @override
  void initState() {
    super.initState();

    Provider.of<CategoriesProvider>(context, listen: false).getCategories();
  }

  int _rowPerPage = PaginatedDataTable.defaultRowsPerPage;
  @override
  Widget build(BuildContext context) {
    final categorias = Provider.of<CategoriesProvider>(context).categorias;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text(
            "Categorías View",
            style: CustomLabels.h1,
          ),
          const SizedBox(height: 10),
          PaginatedDataTable(
            columns: const [
              DataColumn(label: Text("ID")),
              DataColumn(label: Text("Categoria")),
              DataColumn(label: Text("Creado por")),
              DataColumn(label: Text("Acciones")),
            ],
            source: CategoriesDTS(categorias, context),
            header: const Text("Categorias disponibles", maxLines: 2),
            onRowsPerPageChanged: (value) =>
                setState(() => _rowPerPage = value ?? 10),
            rowsPerPage:
                _rowPerPage, //Muestro una cantidad determinada de rows por pagina.
            actions: [
              CustomIconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      //Esto saca los bordes blancos del modal. 
                      //Eliminar la linea y fijarse si no te acordas.
                      backgroundColor: Colors.transparent, 
                      context: context,
                      builder: ((context) => CategoryModal(categoria: null))
                    );
                  },
                  text: "Crear",
                  icon: Icons.add_outlined)
            ],
          )
        ],
      ),
    );
  }
}
