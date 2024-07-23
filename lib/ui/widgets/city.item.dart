import 'package:flutter/material.dart';

class CityItem extends StatelessWidget {
  const CityItem(
      {super.key,
      required this.cityName,
      this.deleteItem,
      this.onTap,
      this.currCitey = false});
  final String cityName;
  final deleteItem;
  final onTap;
  final currCitey;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 10, spreadRadius: 1, color: Colors.grey[500]!)
            ]),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              cityName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            currCitey
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Current City',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Icon(
                        Icons.location_on,
                        color: Colors.blue,
                        size: 30,
                      )
                    ],
                  )
                : IconButton(
                    onPressed: deleteItem,
                    icon: const Icon(Icons.delete, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
