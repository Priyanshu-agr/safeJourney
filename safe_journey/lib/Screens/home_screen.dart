import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:safe_journey/data_base.dart';
import 'package:http/http.dart' as http;
import 'package:safe_journey/models/scam_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  var searchText;
  String? _currentAddress;
  List<Scam> scams = [
    Scam(
        id: "id_abcdefg",
        title: "Title1",
        body:
            "This is the body for title1. Here we can add many things like reviews and comments or a brief description",
        author: "Author1",
        date: DateTime.now(),
        location: "location_1",
        votes: 3,
        coordinatex: 21.54654,
        coordinatey: 64.3146),
    Scam(
        id: "id_hijklmnop_2",
        title: "Title2",
        body:
            "This is the body for title2. Here we can add many things like reviews and comments or a brief description",
        author: "Author2",
        date: DateTime.now(),
        location: "location_2",
        votes: 10,
        coordinatex: 84.849436,
        coordinatey: 54.6482),
  ];
  Position? _currentPosition;
  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  void SubmitData() {
    if (_searchController.text.isNotEmpty) {
      final response = Provider.of<Data>(context, listen: false)
          .sendLocation(_searchController.text)
          .then((value) {
        List<dynamic> tempData = jsonDecode(value);
        setState(() {
          scams = [
            ...tempData.map((element) {
              return Scam(
                  id: element['_id'],
                  title: element['title'],
                  body: element['body'],
                  author: element['author'],
                  date: DateTime.parse(element['date']),
                  location: element['location'],
                  votes: element['votes'],
                  coordinatex: element['coordinatex'],
                  coordinatey: element['coordinatey']);
            })
          ];
        });
        print(scams);
      });
    }
    // _searchController.clear();
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => _currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ListView(
        shrinkWrap: true,
        padding: EdgeInsets.all(10),
        children: [
          Center(
            child: Text(
              "SafeJourney",
              style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
            ),
          ),
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: constraints.maxWidth * 0.65,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 231, 229, 229),
                borderRadius: BorderRadius.circular(1000),
                border: Border.all(
                  width: 1.2,
                  color: Colors.grey,
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: SizedBox(
                        width: constraints.maxWidth * 0.405,
                        child: TextFormField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: "Search",
                            hintStyle: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          onSaved: (value) {
                            searchText = value;
                          },
                          onEditingComplete: () {
                            searchText = _searchController.text;
                          },
                          onTapOutside: (_) {
                            searchText = _searchController.text;
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        SubmitData();
                      },
                      child: Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(7),
                              child: const Icon(Icons.search)),
                          if (constraints.maxWidth > 1050)
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 3),
                                child: const Text("Submit")),
                        ],
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        _getCurrentPosition();
                      },
                      child: Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(7),
                              child: const Icon(Icons.location_on)),
                          if (constraints.maxWidth > 840)
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 3),
                                child: const Text("My Location")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (scams.isNotEmpty)
            GridView.builder(
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              itemCount: scams.length,
              primary: true,
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 3 / 3.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, idx) {
                return Container(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 190, 38, 204),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scams[idx].title,
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(scams[idx].body),
                        Text(
                          "Date : ${scams[idx].date.toString().substring(0, 10)}",
                        ),
                        Text("By ${scams[idx].author}"),
                      ]),
                );
                // return Container(
                //   color: Colors.red,
                // );
              },
            ),
        ],
      );
    });
  }
}
