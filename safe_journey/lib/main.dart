import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safe_journey/Screens/about_us_screen.dart';
import 'package:safe_journey/Screens/address_screen.dart';
import 'package:safe_journey/Screens/contact_us.dart';
import 'package:safe_journey/Screens/home_screen.dart';
import 'package:safe_journey/Screens/input_form.dart';
import 'package:safe_journey/data_base.dart';

void main() {
  runApp(const MyApp());
}

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
          child: const MyHomePage(title: 'Flutter Demo Home Page')),
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
    ContactUsPage(),
    AboutUsScreen(),
  ];

  int screenIdx = 0;

  @override
  Widget build(BuildContext context) {
    final appbarList = Provider.of<Data>(context, listen: false).appBarTitle;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 233, 159, 247),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 233, 159, 247),
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: const BoxDecoration(
                  border: Border(
                      left: BorderSide(
                color: Colors.black,
                width: 1.5,
              ))),
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
        ),
      ),
      body: Screens[screenIdx],
    );
  }
}
