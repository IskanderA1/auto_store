import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kursach_avto_app/model/car_response.dart';
import 'package:kursach_avto_app/model/mark_response.dart';
import 'package:kursach_avto_app/model/model_response.dart';

class AppRepository {
  static String mainUrl = "https://luxury-auto.herokuapp.com";
  var getCarsUrl = "$mainUrl/cars";
  var marksUrl = "$mainUrl/brands";
  var modelUrl = "$mainUrl/models";
  
  var headers = {
    "Content-Type":"application/json"
  };

  final Dio _dio = Dio();

  Future<CarsResponse> getAllCars() async {
    try {
      Response response = await _dio.get(getCarsUrl);
      return CarsResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return CarsResponse.withError("$error");
    }
  }

  Future<MarkResponse> getAllMarks() async {
    try {
      Response response = await _dio.get(marksUrl);
      print(response.data);
      return MarkResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return MarkResponse.withError("$error");
    }
  }

  Future<bool> addMark(String nameMark, String nameCity) async {
    var body = {
      "name":"$nameMark",
      "manufacturer-country":"$nameCity",
    };
    try {
      Response response = await _dio.post(marksUrl,data: body,options: Options(
        headers: headers
      ));
      print(response.data);
      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }
  Future<bool> removeMark(int idMark) async {

    try {
      Response response = await _dio.delete(marksUrl+"/$idMark");
      print(response.data);
      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }
  //===============================================================

  Future<ModelResponse> getAllModels() async {
    try {
      Response response = await _dio.get(modelUrl);
      print(response.data);
      return ModelResponse.fromJson(response.data);
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return ModelResponse.withError("$error");
    }
  }



  Future<bool> addModel(int brandId, String nameModel, String nameColor, String releaseYear) async {
    var body = {
      "name": "$nameModel",
      "possible_colors": "$nameColor",
      "release_year": "$releaseYear",
      "brand_id": brandId,
    };
    try {
      Response response = await _dio.post(modelUrl,data: body,options: Options(
        headers: headers
      ));
      print(response.data);
      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }
  Future<bool> removeModel(int idModel) async {
    try {
      Response response = await _dio.delete(modelUrl+"/$idModel");
      print(response.data);
      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }

  Future<bool> addCars(int modelID,File photo, String color, String power, String releaseYear,String price) async {
    List<int> imageBytes = photo.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    var body = {
      "color": "$color",
      "power": "$power",
      "photo": "$base64Image",
      "release_year": "$releaseYear",
      "model_id": "$modelID",
      "price": "$price"
    };
    try {
      Response response = await _dio.post(getCarsUrl,data: body,options: Options(
        headers: headers
      ));
      print(response.data);
      return true;
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return false;
    }
  }
}
