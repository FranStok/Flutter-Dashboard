import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/UI/Labels/labels.dart';
import '../../Data_tables/users_data_source.dart';
import '../../Providers/users_provider.dart';

class UsersView extends StatelessWidget {
  const UsersView({super.key});

  @override
  Widget build(BuildContext context) {
    final usersProvider = Provider.of<UsersProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          Text(
            "Users View",
            style: CustomLabels.h1,
          ),
          const SizedBox(height: 10),
          PaginatedDataTable(
            sortAscending: usersProvider.ascending,
            sortColumnIndex: usersProvider.sortColumnsIndex,
            columns: [
              DataColumn(label: Text("Avatar")),
              DataColumn(
                  label: Text("Nombre"),
                  onSort: (colIndex, _) {
                    usersProvider.sortColumnsIndex = colIndex;
                    usersProvider.sort((user) => user.nombre);
                  }),
              DataColumn(
                  label: Text("Email"),
                  onSort: (colIndex, _) {
                    usersProvider.sortColumnsIndex = colIndex;
                    usersProvider.sort((user) => user.correo);
                  }),
              DataColumn(label: Text("UID")),
              DataColumn(label: Text("Acciones")),
            ],
            source: UsersDataSource(usersProvider.users),
            onPageChanged: (page) {},
          ),
        ],
      ),
    );
  }
}
