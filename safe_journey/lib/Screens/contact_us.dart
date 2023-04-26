import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});
  static const routeName = '/ContactUsPage';
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: Text("Contact Us Screen")));
  }
}
