import 'package:admin_dashboard/Models/usuario.dart';
import 'package:admin_dashboard/Router/router.dart';
import 'package:admin_dashboard/Services/navigation_service.dart';
import 'package:flutter/material.dart';

class UsersDataSource extends DataTableSource {
  final List<Usuario> users;

  UsersDataSource(this.users);

  @override
  DataRow getRow(int index) {
    final Usuario user = users[index];

    //Al principio, ningun usuario tiene imagen.
    // final image = const Image(
    //   image: AssetImage("no-image.jpg"),
    //   width: 35,
    //   height: 35,
    // );
    final image=(user.img==null)
      ? Image(
          image: AssetImage("no-image.jpg"),
          width: 35,
          height: 35,
        )
      : FadeInImage.assetNetwork(
        placeholder: "loader.gif",
        image: user.img!,
        width:35,
        height: 35,
      );

    return DataRow.byIndex(index: index, cells: [
      DataCell(ClipOval(child: image)), //Hace la imagen redonda.
      DataCell(Text("${user.nombre}")),
      DataCell(Text("${user.correo}")),
      DataCell(Text("${user.uid}")),
      DataCell(IconButton(
        icon: Icon(Icons.edit_outlined),
        onPressed: () {
          NavigationService.replaceTo("${fluroRouter.usersRoute}/${user.uid}");
        },
      )),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => users.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
