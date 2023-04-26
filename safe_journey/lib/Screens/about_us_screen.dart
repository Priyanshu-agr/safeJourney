import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});
  static const routeName = '/AboutUsScreen';

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("About Us Screen"),
      ),
    );
  }
}
