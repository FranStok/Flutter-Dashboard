//Este archivo lo genero quickType.
class Categoria {
    Categoria({
        required this.id,
        required this.nombre,
        required this.usuario,
    });

    String id;
    String nombre;
    _Usuario usuario;

    factory Categoria.fromJson(Map<String, dynamic> json) => Categoria(
        id: json["_id"],
        nombre: json["nombre"],
        usuario: _Usuario.fromJson(json["usuario"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
        "usuario": usuario.toJson(),
    };
    @override
  String toString() {
    return "Categoria: ${this.nombre}";
  }
}

class _Usuario {
    _Usuario({
        required this.id,
        required this.nombre,
    });

    String id;
    String nombre;

    factory _Usuario.fromJson(Map<String, dynamic> json) => _Usuario(
        id: json["_id"],
        nombre: json["nombre"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "nombre": nombre,
    };
}