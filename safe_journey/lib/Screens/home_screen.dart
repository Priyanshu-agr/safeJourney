import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:safe_journey/data_base.dart';
import 'package:safe_journey/models/scam_model.dart';

// 395 - 345

class HomeScreen extends StatefulWidget {
  HomeScreen({super.key});
  static const routeName = '/HomeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  var searchText;
  // String? _currentAddress;
  // List<Scam> scams = [
  //   Scam(
  //       id: "id_abcdefg",
  //       title: "Title1",
  //       body:
  //           "This is the body for title1. Here we can add many things like reviews and comments or a brief description",
  //       author: "Author1",
  //       date: DateTime.now(),
  //       location: "location_1",
  //       votes: 3,
  //       coordinatex: 21.54654,
  //       coordinatey: 64.3146),
  //   Scam(
  //       id: "id_hijklmnop_2",
  //       title: "Title2",
  //       body:
  //           "This is the body for title2. Here we can add many things like reviews and comments or a brief description",
  //       author: "Author2",
  //       date: DateTime.now(),
  //       location: "location_2",
  //       votes: 10,
  //       coordinatex: 84.849436,
  //       coordinatey: 54.6482),
  //   Scam(
  //       id: "id_hijklmnop_3",
  //       title: "Title2",
  //       body:
  //           "This is the body for title3. Here we can add many things like reviews and comments or a brief description",
  //       author: "Author3",
  //       date: DateTime.now(),
  //       location: "location_3",
  //       votes: 10,
  //       coordinatex: 84.849436,
  //       coordinatey: 54.6482),
  //   Scam(
  //       id: "id_hijklmnop_4",
  //       title: "Title4",
  //       body:
  //           "This is the body for title4. Here we can add many things like reviews and comments or a brief description",
  //       author: "Author4",
  //       date: DateTime.now(),
  //       location: "location_4",
  //       votes: 10,
  //       coordinatex: 84.849436,
  //       coordinatey: 54.6482),
  //   Scam(
  //       id: "id_hijklmnop_5",
  //       title: "Title5",
  //       body:
  //           "This is the body for title5. Here we can add many things like reviews and comments or a brief description",
  //       author: "Author5",
  //       date: DateTime.now(),
  //       location: "location_5",
  //       votes: 10,
  //       coordinatex: 84.849436,
  //       coordinatey: 54.6482),
  //   Scam(
  //       id: "id_hijklmnop_6",
  //       title: "Title6",
  //       body:
  //           "This is the body for title2. Here we can add many things like reviews and comments or a brief description",
  //       author: "Author6",
  //       date: DateTime.now(),
  //       location: "location_6",
  //       votes: 10,
  //       coordinatex: 84.849436,
  //       coordinatey: 54.6482),
  //   Scam(
  //       id: "id_hijklmnop_7",
  //       title: "Title7",
  //       body:
  //           "This is the body for title7. Here we can add many things like reviews and comments or a brief description",
  //       author: "Author7",
  //       date: DateTime.now(),
  //       location: "location_7",
  //       votes: 10,
  //       coordinatex: 84.849436,
  //       coordinatey: 54.6482),
  // ];
  List<Scam> scams = [];

  Position? _currentPosition;
  bool isLoading = false;
  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  void submitData() {
    if (_searchController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
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
        setState(() {
          isLoading = false;
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
    if (kDebugMode) {
      print(hasPermission);
    }
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
        primary: true,
        // shrinkWrap: true,
        padding: const EdgeInsets.all(10),
        children: [
          if (MediaQuery.of(context).size.width < 883 &&
              MediaQuery.of(context).size.width > 400)
            Center(
              child: Container(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  "SafeJourney",
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge
                      ?.copyWith(fontWeight: FontWeight.bold, fontSize: 40),
                ),
              ),
            ),
          if (MediaQuery.of(context).size.width > 883)
            const Center(
              child: Text(
                "SafeJourney",
                style: TextStyle(fontSize: 100, fontWeight: FontWeight.bold),
              ),
            ),
          Center(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: (MediaQuery.of(context).size.width > 630)
                  ? constraints.maxWidth * 0.65
                  : constraints.maxWidth * 0.8,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 231, 229, 229),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: SizedBox(
                        width: constraints.maxWidth * 0.405,
                        child: TextFormField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                              hintText: "Search",
                              hintStyle: TextStyle(
                                fontSize: 20,
                              ),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                color: Color(0xff0074fc),
                                width: 1.5,
                              ))),
                          autofocus: false,
                          onSaved: (value) {
                            searchText = value;
                            if (kDebugMode) {
                              print("onSaved Triggered");
                            }
                          },
                          onEditingComplete: () {
                            searchText = _searchController.text;
                            if (kDebugMode) {
                              print("onEditingComplete Triggered");
                            }
                          },
                          onTapOutside: (_) {
                            searchText = _searchController.text;
                            if (kDebugMode) {
                              print("onTapOutside Triggered");
                            }
                          },
                          onFieldSubmitted: (_) {
                            if (kDebugMode) {
                              print("onFieldSubmit Triggered");
                            }
                            submitData();
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () {
                        submitData();
                      },
                      child: Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(7),
                              child: const Icon(Icons.search)),
                          if (constraints.maxWidth > 1050)
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: const Text("Submit")),
                        ],
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(100),
                      onTap: () async {
                        await _getCurrentPosition();
                        if (kDebugMode) {
                          print("Thankyou for your location permission");
                          print(_currentPosition?.latitude);
                          print(_currentPosition?.longitude);
                          print(jsonEncode({"coordinates": _currentPosition}));
                        }
                        // TODO : send coordinates to server

                        setState(() {
                          isLoading = true;
                        });
                        final response =
                            Provider.of<Data>(context, listen: false)
                                .sendCoordinates({"coordinates": _currentPosition})
                                .then((value) {
                          List<dynamic> tempData = jsonDecode(value);
                          setState(() {
                            scams.clear();
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
                          setState(() {
                            isLoading = false;
                          });
                          print(scams);
                        });
                      
                      },
                      child: Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.all(7),
                              child: const Icon(Icons.location_on)),
                          if (constraints.maxWidth > 840)
                            Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 3),
                                child: const Text("My Location")),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (isLoading)
            Container(
              height: MediaQuery.of(context).size.height * 0.5,
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.lightBlue,
                ),
              ),
            ),
          if (scams.isNotEmpty && isLoading == false)
            GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
              itemCount: scams.length,
              // primary: true,
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 300,
                childAspectRatio: 3 / 4.06,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, idx) {
                return Container(
                  decoration: BoxDecoration(
                    // color: Color.fromARGB(255, 190, 38, 204),
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          scams[idx].title,
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Wrap(
                            // fit: BoxFit.contain,
                            children: [
                              Text(scams[idx].body),
                            ]),
                        if (constraints.maxWidth > 390 ||
                            constraints.maxWidth < 345)
                          Text(
                            "Date : ${scams[idx].date.toString().substring(0, 10)}",
                          ),
                        Text("By ${scams[idx].author}"),
                      ]),
                );
              },
            ),
        ],
      );
    });
  }
}
