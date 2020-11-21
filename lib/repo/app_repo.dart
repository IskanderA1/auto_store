import 'package:dio/dio.dart';
import 'package:kursach_avto_app/model/car_response.dart';
import 'package:kursach_avto_app/model/mark_response.dart';

class AppRepository {
  static String mainUrl = "https://luxury-auto.herokuapp.com";
  var getCarsUrl = "$mainUrl/cars";
  var marksUrl = "$mainUrl/brands";
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
}
