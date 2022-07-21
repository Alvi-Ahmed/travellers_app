import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../models/placesModel.dart';
import '../provider/place_provider.dart';

class TravelPlaceCard extends StatelessWidget {
  final Places place;
  const TravelPlaceCard(this.place, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final location = context.watch<PlaceProvider>().currentLocation;
    final distance = Geolocator.distanceBetween(
            location!.latitude, location.longitude, place.lat, place.long) ~/
        1000;
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Image.network(
            place.image,
            height: 100.0,
            width: 100.0,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              place.placeName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.all(3.0),
                  child: Icon(Icons.directions_car),
                ),
                Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: Text(
                    place.city,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                        color: Colors.grey),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: const [
                      Icon(Icons.money),
                      Text("0"),
                      Icon(Icons.euro),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: const [Icon(Icons.alarm), Text("5h")],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                      const Icon(Icons.swap_horiz),
                      Text("$distance  km")
                    ],
                  ),
                ),
              ],
            ),
            const Divider(
              height: 20,
              thickness: 5,
              indent: 20,
              endIndent: 0,
              color: Colors.black,
            ),
          ],
        )
      ],
    );
  }
}
