import 'dart:typed_data';

import 'package:admin_dashboard/Services/local_storage.dart';
import 'package:dio/dio.dart';

class CafeApi {
  static Dio _dio = Dio();

  static void configureDio() {
    //Cada vez que usemos esta instancia de dio, le concatena BaseUrl, que todos los url lo tienen.
    _dio.options.baseUrl = "http://localhost:8080/api";

    //Configurar headers
    _dio.options.headers = {
      "x-token": LocalStorage.prefs.getString("token") ?? ""
    };
  }

  static Future httpGet(String path) async {
    try {
      final response = await _dio.get(path); //Peticion http.
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      throw ("Error en el GET");
    }
  }

  static Future post(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final response = await _dio.post(path,data: formData); //Peticion http.
      return response.data;
    } on DioError catch (e) {
      throw ("Error en el Post ${e.response}");
    }
  }
  static Future put(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final response = await _dio.put(path,data: formData); //Peticion http.
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      throw ("Error en el put");
    }
  }
  static Future delete(String path, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final response = await _dio.delete(path,data: formData); //Peticion http.
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      throw ("Error en el delete");
    }
  }
  static Future uploadFile(String path, Uint8List bytes) async {
    final formData = FormData.fromMap({
      "archivo": MultipartFile.fromBytes(bytes)
    });

    try {
      final response = await _dio.put(path,data: formData); //Peticion http.
      return response.data;
    } on DioError catch (e) {
      print(e.response);
      throw ("Error en el put");
    }
  }
}
