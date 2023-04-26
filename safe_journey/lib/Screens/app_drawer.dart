import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            InkWell(
              onTap: (){},
              child: const ListTile(
                leading: Icon(Icons.home_filled),
                title: Text("Home"),
              ),
            ),
            InkWell(
              onTap: (){},
              child: const ListTile(
                leading: Icon(Icons.home_filled),
                title: Text("Create Scam"),
              ),
            ),
            InkWell(
              onTap: (){},
              child: const ListTile(
                leading: Icon(Icons.home_filled),
                title: Text("Contact Us"),
              ),
            ),
            InkWell(
              onTap: (){},
              child: const ListTile(
                leading: Icon(Icons.home_filled),
                title: Text("About Us"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
