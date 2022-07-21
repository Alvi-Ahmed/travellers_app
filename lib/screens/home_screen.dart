// screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/place_provider.dart';
import '../widgets/travel_place_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(milliseconds: 100), () {
      context.read<PlaceProvider>().loadPlaces();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var placeList = context.watch<PlaceProvider>().allplaces;
    final permission = context.watch<PlaceProvider>().permissionGranted;
    final loading = context.watch<PlaceProvider>().loading;

    return Scaffold(
      body: SafeArea(
        child: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : !permission
                ? Center(
                    child: TextButton(
                        onPressed: () {
                          context.read<PlaceProvider>().loadPlaces();
                        },
                        child: const Text('We need your location permission')),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: const [
                          Text(
                            "Meine",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            "Touren",
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize: 32,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: placeList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return TravelPlaceCard(placeList[index]);
                            }),
                      ),
                    ]),
                  ),
      ),
    );
  }
}
