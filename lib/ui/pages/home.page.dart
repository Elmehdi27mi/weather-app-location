// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/weatherScreenCity.dart';
import 'package:location/ui/widgets/city.item.dart';
import 'package:location/ui/widgets/textfiled.custom.dart';
import 'package:location/weatherScreen.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final textController = TextEditingController();
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  List cities = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                const Color(0xff007EF4),
                const Color(0xff2A75BC),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(60.0),
            ),
          ),
        ),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 10),
            Text(
              'Weather App',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Spacer(), // Ajout de Spacer pour centrer le texte et l'image
          ],
        ),
        backgroundColor: Colors
            .transparent, // Rendre l'arrière-plan de l'AppBar transparent pour voir le dégradé
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
          child: Column(
            children: [
              _buildHeader(),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: _buldItemCurrent(context),
              ),
              Container(
                margin: EdgeInsets.only(top: 40, bottom: 20),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.blue,
                        size: 30,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'Mes villes',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ),
              _buldItems(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() => Row(
        children: [
          Expanded(
              flex: 4,
              child: MyTextFiled(hintText: "city", controller: textController)),
          Expanded(
            flex: 1,
            child: Container(
                margin: const EdgeInsets.only(right: 10),
                height: 50,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xff007EF4),
                      const Color(0xff2A75BC),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: MaterialButton(
                  onPressed: () {
                    setState(() {
                      cities.add(textController.text);
                    });
                    textController.clear();
                  },
                  child: Text(
                    "add",
                    style: TextStyle(color: Colors.white),
                  ),
                )),
          ),
        ],
      );

  Widget _buldItems(context) {
    return Container(
      height: MediaQuery.of(context).size.height * .8,
      child: ListView.builder(
          itemCount: cities.length,
          itemBuilder: (c, index) => CityItem(
                cityName: cities[index],
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (c) => WeatherPageCity(
                                city: cities[index],
                              )));
                },
                deleteItem: () {
                  setState(() {
                    cities.removeAt(index);
                  });
                },
              )),
    );
  }

  Widget _buldItemCurrent(context) {
    return Container(
        height: 100,
        child: CityItem(
          currCitey: true,
          cityName: "Settat",
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (c) => WeatherPage(
                          city: "Settat",
                        )));
          },
        ));
  }
}
