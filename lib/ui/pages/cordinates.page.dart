import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class CoordinatesPage extends StatelessWidget {
  const CoordinatesPage({Key? key, required this.cityName}) : super(key: key);
  final String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coordonnées'),
      ),
      body: FutureBuilder<List<Location>>(
        future: locationFromAddress(cityName),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Erreur : ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child:
                  Text('Aucune donnée de localisation trouvée pour $cityName'),
            );
          } else {
            final location = snapshot.data!.first;
            return Center(
              child: Container(
                height: 200,
                width: 400,
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 10,
                          spreadRadius: 1,
                          color: Colors.grey[500]!)
                    ]),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "City name : $cityName",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Latitude : ${location.latitude}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Longitude : ${location.longitude}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
