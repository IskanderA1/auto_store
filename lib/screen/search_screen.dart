import 'package:flutter/material.dart';
import 'package:kursach_avto_app/bloc/search_bloc.dart';
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
    searchBloc.getAllCars();
    _searchController.addListener(_onSearchChanged);
    super.initState();
  }

  _onSearchChanged() {
    
  }
  @override
  void dispose() {
    ///_searchController.dispose();
    _searchController.removeListener(_onSearchChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
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
      stream: searchBloc.subject,
      // ignore: missing_return
      builder: (context,AsyncSnapshot<CarsResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null &&
              snapshot.data.error.length > 0) {
            return Container();
          }
          return ListView.builder(
              itemCount: snapshot.data.cars.length,
              itemBuilder: (context, index) {
                return _buildCarItem(snapshot.data.cars[index]);
              });
        }else{
          return buildLoadingWidget();
        }
      }
    );
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
              flex: 5,
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
              flex: 9,
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
                            "Модель: ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Style.standardTextColor,
                            ),
                          ),
                          Text(
                            "${carModel.modelName}",
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
                            "Кузов: ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Style.standardTextColor,
                            ),
                          ),
                          Text(
                            "${carModel.carBody}",
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
                            "В налчие: ",
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Style.standardTextColor,
                            ),
                          ),
                          Text(
                            "${carModel.availability}",
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

          ],
        ),
      ),
    );
  }
}



