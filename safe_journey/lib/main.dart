import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_journey/Screens/about_us_screen.dart';
import 'package:safe_journey/Screens/address_screen.dart';
import 'package:safe_journey/Screens/app_drawer.dart';
import 'package:safe_journey/Screens/contact_us.dart';
import 'package:safe_journey/Screens/home_screen.dart';
import 'package:safe_journey/Screens/input_form.dart';
import 'package:safe_journey/data_base.dart';
import 'data_base.dart';

void main() {
  runApp(const MyApp());
}

// 300 and 630

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple, useMaterial3: true),
      home: ChangeNotifierProvider(
        create: (context) => Data(),
        child: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var Screens = [
    HomeScreen(),
    InputForm(),
    const ContactUsPage(),
    const AboutUsScreen(),
  ];
  final appbarItems = Data().getappBarItems;
  final appbarList = [...Data().getappBarItems.keys];

  int screenIdx = 0;

  @override
  Widget build(BuildContext context) {
    // final appbarList = Provider.of<Data>(context, listen: false).getappBarTitle;
    return (MediaQuery.of(context).size.width < 885 &&
            MediaQuery.of(context).size.width > 400)
        ? Scaffold(
            backgroundColor: Color.fromARGB(255, 233, 159, 247),
            // appBar: AppBar(
            //   backgroundColor: Color.fromARGB(255, 233, 159, 247),
            //   centerTitle: true,
            //   title: (MediaQuery.of(context).size.width > 885)
            //       ? Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Container(
            //               decoration: const BoxDecoration(
            //                 border: Border(
            //                   left: BorderSide(
            //                     color: Colors.black,
            //                     width: 1.5,
            //                   ),
            //                 ),
            //               ),
            //               child: Row(
            //                 children: [
            //                   ...appbarList.map((e) {
            //                     // return AppBarButton(title: e, index: appbarList.indexOf(e));
            //                     return InkWell(
            //                       onTap: () {
            //                         final index = appbarList.indexOf(e);
            //                         print("${appbarList.indexOf(e)} : $e");
            //                         setState(() {
            //                           screenIdx = index;
            //                         });
            //                       },
            //                       child: Container(
            //                         decoration: const BoxDecoration(
            //                           border: Border(
            //                             bottom: BorderSide(
            //                               color: Colors.black,
            //                               width: 1.5,
            //                             ),
            //                             right: BorderSide(
            //                               color: Colors.black,
            //                               width: 1.5,
            //                             ),
            //                           ),
            //                         ),
            //                         padding: const EdgeInsets.all(8),
            //                         child: Text(
            //                           e,
            //                         ),
            //                       ),
            //                     );
            //                   }),
            //                 ],
            //               ),
            //             ),
            //           ],
            //         )
            //       : Text(
            //           "SafeJourney",
            //           style: Theme.of(context)
            //               .textTheme
            //               .headlineLarge
            //               ?.copyWith(fontWeight: FontWeight.bold),
            //         ),
            // ),
            body: Row(
              children: [
                Expanded(
                  flex: 5,
                  child: Container(
                    color: Color.fromARGB(255, 233, 159, 247),
                    child: Column(
                      children: [
                        ...appbarItems.entries.map((e) {
                          return Column(
                            children: [
                              (MediaQuery.of(context).size.width < 735)
                                  ? ListTile(
                                      title: Icon(e.value),
                                      onTap: () {
                                        final index = appbarList.indexOf(e.key);
                                        print(
                                            "${appbarList.indexOf(e.key)} : ${e.key}");
                                        setState(() {
                                          screenIdx = index;
                                        });
                                      },
                                    )
                                  : ListTile(
                                      onTap: () {
                                        final index = appbarList.indexOf(e.key);
                                        print(
                                            "${appbarList.indexOf(e.key)} : ${e.key}");
                                        setState(() {
                                          screenIdx = index;
                                        });
                                      },
                                      leading: Icon(e.value),
                                      title: Text(
                                        e.key,
                                        style: TextStyle(fontSize: 12),
                                      ),
                                    ),
                              Divider(
                                color: Colors.grey,
                              ),
                            ],
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
                Expanded(flex: 20, child: Screens[screenIdx]),
              ],
            ),
          )
        : (MediaQuery.of(context).size.width < 400)
            ? Scaffold(
                backgroundColor: Color.fromARGB(255, 233, 159, 247),
                appBar: AppBar(
                  backgroundColor: Color.fromARGB(255, 233, 159, 247),
                  centerTitle: true,
                  title: (MediaQuery.of(context).size.width > 630)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  ...appbarList.map((e) {
                                    // return AppBarButton(title: e, index: appbarList.indexOf(e));
                                    return InkWell(
                                      onTap: () {
                                        final index = appbarList.indexOf(e);
                                        print("${appbarList.indexOf(e)} : $e");
                                        setState(() {
                                          screenIdx = index;
                                        });
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                            right: BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          e,
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Text(
                          "SafeJourney",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                ),
                body: Screens[screenIdx],
                drawer: Drawer(
                  child: SafeArea(
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            final index = appbarList.indexOf("Home");
                            // print("${appbarList.indexOf(e.key)} : ${e.key}");
                            setState(() {
                              screenIdx = index;
                            });
                            // Navigator.of(context).pushNamed(HomeScreen.routeName);
                            Navigator.of(context).pop();
                          },
                          child: ListTile(
                            leading: Icon(Icons.home_filled),
                            title: Text("Home"),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final index = appbarList.indexOf("Create Scam");
                            // print("${appbarList.indexOf(e.key)} : ${e.key}");
                            setState(() {
                              screenIdx = index;
                            });
                            // Navigator.of(context).pushNamed();
                            Navigator.of(context).pop();
                          },
                          child: ListTile(
                            leading: Icon(Icons.add),
                            title: Text("Create Scam"),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final index = appbarList.indexOf("Contact Us");
                            // print("${appbarList.indexOf(e.key)} : ${e.key}");
                            setState(() {
                              screenIdx = index;
                            });
                            // Navigator.of(context).pushNamed(ContactUsPage.routeName);
                            Navigator.of(context).pop();
                          },
                          child: ListTile(
                            leading: Icon(Icons.message_outlined),
                            title: Text("Contact Us"),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            final index = appbarList.indexOf("About Us");
                            // print("${appbarList.indexOf(e.key)} : ${e.key}");
                            setState(() {
                              screenIdx = index;
                            });
                            // Navigator.of(context).pushNamed(AboutUsScreen.routeName);
                            Navigator.of(context).pop();
                          },
                          child: ListTile(
                            leading: Icon(Icons.corporate_fare_outlined),
                            title: Text("About Us"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Scaffold(
                backgroundColor: Color.fromARGB(255, 233, 159, 247),
                appBar: AppBar(
                  backgroundColor: Color.fromARGB(255, 233, 159, 247),
                  centerTitle: true,
                  title: (MediaQuery.of(context).size.width > 630)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                border: Border(
                                  left: BorderSide(
                                    color: Colors.black,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  ...appbarList.map((e) {
                                    // return AppBarButton(title: e, index: appbarList.indexOf(e));
                                    return InkWell(
                                      onTap: () {
                                        final index = appbarList.indexOf(e);
                                        print("${appbarList.indexOf(e)} : $e");
                                        setState(() {
                                          screenIdx = index;
                                        });
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                            right: BorderSide(
                                              color: Colors.black,
                                              width: 1.5,
                                            ),
                                          ),
                                        ),
                                        padding: const EdgeInsets.all(8),
                                        child: Text(
                                          e,
                                        ),
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Text(
                          "SafeJourney",
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                ),
                body: Screens[screenIdx],
              );
  }
}

// (MediaQuery.of(context).size.width < 630 && MediaQuery.of(context).size.width > 300)
