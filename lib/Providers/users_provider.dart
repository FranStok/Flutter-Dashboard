import 'package:admin_dashboard/Api/cafeApi.dart';
import 'package:admin_dashboard/Models/Http/users_response.dart';
import 'package:admin_dashboard/Models/usuario.dart';
import 'package:flutter/foundation.dart';

class UsersProvider extends ChangeNotifier {
  List<Usuario> users = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumnsIndex;

  UsersProvider() {
    getPaginatedUsers();
  }

  getPaginatedUsers() async {
    final response = UsersResponse.fromJson(
        await CafeApi.httpGet("/usuarios?limite=100&desde=0"));
    users = response.usuarios;
    isLoading = false;
    notifyListeners();
  }

  Future<Usuario?> getUserById(String uid) async {
    try {
      final response = await CafeApi.httpGet("/usuarios/$uid");
      final user = Usuario.fromJson(response);
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void sort<T>(Comparable<T> Function(Usuario user) getField) {
    users.sort((user1, user2) {
      final value1 = getField(user1);
      final value2 = getField(user2);
      return ascending
          ? Comparable.compare(value1, value2)
          : Comparable.compare(value2, value1);
    });
    ascending = !ascending;
    notifyListeners();
  }

  void refreshUser(Usuario? newUser) {
    if(newUser!=null){
      int index = users.indexWhere((user) => user.uid == newUser.uid);
      users[index] = newUser;
      notifyListeners();
    }
  }
}
