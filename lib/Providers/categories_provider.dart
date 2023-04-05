import 'package:admin_dashboard/Api/cafeApi.dart';
import 'package:admin_dashboard/Models/Http/categories_response.dart';
import 'package:flutter/material.dart';

import '../Models/categoria.dart';

class CategoriesProvider extends ChangeNotifier {
  List<Categoria> categorias = [];

  getCategories() async {
    // "/categorias" viene del endpoint de obtener categorias
    final response = await CafeApi.httpGet("/categorias");
    final categoriesResponse = CategoriesResponse.fromJson(response);

    //Esto toma categorias y le agrega categoriesResponse.categorias
    categorias = [...categoriesResponse.categorias];

    notifyListeners();
  }

  Future newCategory(String name) async {
    final data = {"nombre": name};

    try {
      final json = await CafeApi.post("/categorias", data);
      final newCategory = Categoria.fromJson(json);
      categorias.add(newCategory);
      notifyListeners();
    } catch (e) {
      throw "Error al crear categoria";
    }
  }

  Future updateCategory(String id, String name) async {
    final data = {"nombre": name};

    try {
      int index = categorias.indexWhere((categoria) => categoria.id == id);
      await CafeApi.put("/categorias/$id", data);
      categorias[index].nombre = name;
      notifyListeners();
    } catch (e) {
      throw "Error al actualizar categoria";
    }
  }

  Future deleteCategory(String id) async {
    try {
      await CafeApi.delete("/categorias/$id", {/*Mapa vacio*/});
      categorias.removeWhere((cat) => cat.id == id);
      notifyListeners();
    } catch (e) {
      print(e);
      print("Error al eliminar categoria");
    }
  }
}
