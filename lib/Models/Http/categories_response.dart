// To parse this JSON data, do
//
//     final categoriesResponse = categoriesResponseFromJson(jsonString);
//Este archivo lo genero quickType.
import 'dart:convert';

import '../categoria.dart';

CategoriesResponse categoriesResponseFromJson(String str) => CategoriesResponse.fromJson(json.decode(str));

String categoriesResponseToJson(CategoriesResponse data) => json.encode(data.toJson());

class CategoriesResponse {
    CategoriesResponse({
        required this.total,
        required this.categorias,
    });

    int total;
    List<Categoria> categorias;

    factory CategoriesResponse.fromJson(Map<String, dynamic> json) => CategoriesResponse(
        total: json["total"],
        categorias: List<Categoria>.from(json["categorias"].map((x) => Categoria.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "categorias": List<dynamic>.from(categorias.map((x) => x.toJson())),
    };
}


