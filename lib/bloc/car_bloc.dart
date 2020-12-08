import 'dart:io';

import 'package:kursach_avto_app/model/car_response.dart';
import 'package:kursach_avto_app/repo/app_repo.dart';
import 'package:rxdart/rxdart.dart';

class CarsBloc {
  final AppRepository _repository = AppRepository();
  final BehaviorSubject<CarsResponse> _subject =
      BehaviorSubject<CarsResponse>();

  addCar(int modelID, File photo, String color, String power,
      String releaseYear, String price) async {
    _subject.sink.add(CarsResponse.withError("Loading"));
    if (await _repository.addCars(
        modelID, photo, color, power, releaseYear, price)) {
      _subject.sink.add(CarsResponse.withError("Успешно"));
    } else {
      _subject.sink.add(CarsResponse.withError("Неудача"));
    }
    
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<CarsResponse> get subject => _subject;
}

final carsBloc = CarsBloc();
