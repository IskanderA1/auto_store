

import 'package:kursach_avto_app/model/car_response.dart';
import 'package:kursach_avto_app/repo/app_repo.dart';
import 'package:rxdart/rxdart.dart';

class SearchPlaceBloc{
  final AppRepository _repository = AppRepository();
  final BehaviorSubject<CarsResponse> _subject =
  BehaviorSubject<CarsResponse>();

  getAllCars() async{
    CarsResponse response = await _repository.getAllCars();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<CarsResponse> get subject => _subject;

}
final searchBloc = SearchPlaceBloc();