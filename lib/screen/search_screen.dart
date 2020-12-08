import 'package:flutter/material.dart';
import 'package:kursach_avto_app/bloc/car_bloc.dart';

import 'package:kursach_avto_app/elements/loader.dart';
import 'package:kursach_avto_app/model/car_response.dart';
import 'package:kursach_avto_app/style/style.dart';
import 'package:kursach_avto_app/model/car_model.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    carsBloc.getAllCars();
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {}
  @override
  void dispose() {
    ///_searchController.dispose();
    _searchController.removeListener(_onSearchChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: Style.mainColor,
        appBar: AppBar(
          toolbarHeight: 80,
          title: Text(
            "ГеликStore",
            style: TextStyle(
                fontFamily: "HelveticaNeueBold.ttf",
                color: Style.standardTextColor,
                fontSize: 34,
                fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: Column(
          children: [
            Container(
              child: _buildSearchTextField(),
            ),
            Expanded(
                flex: 5,
                child: Container(
                  child: _buildResultsList(),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchTextField() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextField(
              controller: _searchController,
              style: TextStyle(
                color: Style.standardTextColor,
                fontFamily: 'OpenSans',
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.search,
                  color: Style.titleColor,
                ),
                hintText: 'Search...',
                hintStyle: kHintTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsList() {
    return StreamBuilder(
        stream: carsBloc.subject,
        // ignore: missing_return
        builder: (context, AsyncSnapshot<CarsResponse> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.error != null && snapshot.data.error.length > 0) {
              if(snapshot.data.error== "Loading"){
                return buildLoadingWidget();
              }
              return Container();
            }
            return ListView.builder(
                itemCount: snapshot.data.cars.length,
                itemBuilder: (context, index) {
                  return _buildCarItem(snapshot.data.cars[index]);
                });
          } else {
            return buildLoadingWidget();
          }
        });
  }

  Widget _buildCarItem(CarModel carModel) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 15),
      child: Container(
        height: 140,
        decoration: kListItemBoxDecorationStyle,
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Container(
                width: 110,
                height: 140,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      bottomLeft: Radius.circular(25)),
                  child: Image.memory(
                    carModel.photo,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        carModel.name,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Style.standardTextColor,
                        ),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text(
                            "Мощность: ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Style.standardTextColor,
                            ),
                          ),
                          Text(
                            "${carModel.power}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Style.titleColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text(
                            "Год: ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Style.standardTextColor,
                            ),
                          ),
                          Text(
                            "${carModel.releaseYear}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Style.titleColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text(
                            "Цвет: ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Style.standardTextColor,
                            ),
                          ),
                          Text(
                            "${carModel.color}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Style.titleColor,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      Row(
                        children: [
                          Text(
                            "Цена: ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Style.standardTextColor,
                            ),
                          ),
                          Text(
                            "${carModel.price}",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Style.titleColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                width: 110,
                height: 140,
                child: GestureDetector(
                  onTap: () {
                    carsBloc.removeCar(carModel.id);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(25),
                        bottomRight: Radius.circular(25)),
                    child: Container(
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                      ),
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
