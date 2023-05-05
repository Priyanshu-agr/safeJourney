import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:provider/provider.dart';

import '../data_base.dart';

class InputForm extends StatefulWidget {
  InputForm({super.key});

  static const routeName = '/InputForm';

  @override
  State<InputForm> createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  var title;

  var body;

  var author;

  DateTime? date = DateTime.now();

  var location;

  final titlecontroller = TextEditingController();

  final bodycontroller = TextEditingController();

  final authorcontroller = TextEditingController();

  final datecontroller = TextEditingController();

  final locationcontroller = TextEditingController();

  final _form = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    titlecontroller.dispose();
    bodycontroller.dispose();
    authorcontroller.dispose();
    datecontroller.dispose();
    locationcontroller.dispose();
    super.dispose();
  }

  void SubmitForm() {
    Map<String, String> toSend = {
      'title': title,
      'body': body,
      'author': author,
      'date': date.toString(),
      'location': location,
    };
    Provider.of<Data>(context, listen: false).sendData(toSend);
    titlecontroller.clear();
    bodycontroller.clear();
    authorcontroller.clear();
    datecontroller.clear();
    locationcontroller.clear();
    _form.currentState?.save();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constrains) {
      return Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            TextFormField(
              controller: titlecontroller,
              decoration: InputDecoration(
                  hintText: "Enter Title", label: Text("Title")),
              onTapOutside: (_) {
                title = titlecontroller.text;
              },
            ),
            TextFormField(
              controller: bodycontroller,
              decoration: InputDecoration(
                  hintText: "Enter body text", label: Text("Body")),
              onTapOutside: (_) {
                body = bodycontroller.text;
              },
            ),
            TextFormField(
              controller: authorcontroller,
              decoration: const InputDecoration(
                hintText: "Enter author",
                label: Text(
                  "Author",
                ),
              ),
              onTapOutside: (_) {
                author = authorcontroller.text;
              },
            ),
            Row(
              children: [
                SizedBox(
                  width: constrains.maxWidth * 0.5,
                  child: TextField(
                    controller: datecontroller,
                    decoration: InputDecoration(
                      label: Text("Enter Date"),
                    ),
                    onTap: () async {
                      DateTime? newSelectedDate = await showDatePicker(
                        context: context,
                        initialDate: date ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                      );

                      if (newSelectedDate != null) {
                        date = newSelectedDate;
                        datecontroller
                          ..text = DateFormat.yMMMd().format(date!)
                          ..selection = TextSelection.fromPosition(
                            TextPosition(
                              offset: datecontroller.text.length,
                              affinity: TextAffinity.upstream,
                            ),
                          );
                      }
                    },
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: locationcontroller,
              decoration: InputDecoration(
                  hintText: "Enter location", label: Text("Location")),
              onTapOutside: (_) {
                location = locationcontroller.text;
              },
            ),
            SizedBox(
              height: 20,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: ElevatedButton(
                onPressed: () {
                  SubmitForm();
                },
                child: Container(
                    child: Text("Submit"),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
