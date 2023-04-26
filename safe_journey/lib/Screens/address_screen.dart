import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});
  static const routeName = '/AddressScreen';
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Text("Address Screen"),
      ),
    );
  }
}
