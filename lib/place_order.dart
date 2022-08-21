import 'dart:convert';
import 'package:double_back_to_close/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_store/main.dart';
import 'package:pet_store/widgets/tag_preview.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'utils/utils.dart';

class Place_Order extends StatefulWidget {
  const Place_Order({Key? key}) : super(key: key);

  @override
  _Place_OrderState createState() => _Place_OrderState();
}

class _Place_OrderState extends State<Place_Order> {
  var random = new Random();
  DateTime selectedDate = DateTime.now();
  TextEditingController mycontroller = TextEditingController();

  bool isSwitched = false;
  bool isDateSelected = false;
  bool value1 = false;

  String? dropdownvalue;
  var items = [
    'placed',
    'approved',
    'delivered',
  ];

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Place an Order'),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            // Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) =>
                    PetStoreHomePage(LoggedIn: true),
              ),
              (route) => false,
            );
          },
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                DropdownButton(
                  hint: const Text('Select Order Status'),
                  value: dropdownvalue,
                  icon: const Icon(Icons.keyboard_arrow_down),
                  items: items.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Text(items),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      dropdownvalue = newValue!;
                    });
                  },
                ),
                Card(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 100),
                  // elevation: 8,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                        color: Color.fromARGB(179, 161, 159, 159), width: 1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ListTile(
                        title: (isDateSelected == false)
                            ? Text("Choose a date",
                                style: TextStyle(
                                    fontSize: 17,
                                    color: Color.fromARGB(255, 85, 83, 83)))
                            : Text(
                                "${selectedDate.toLocal()}".split(' ')[0],
                                style: TextStyle(fontSize: 17),
                              ),
                        trailing: GestureDetector(
                          child: Icon(
                            Icons.calendar_month,
                            color: Color.fromARGB(255, 85, 83, 83),
                          ),
                          onTap: () {
                            isDateSelected = true;
                            _selectDate(context);
                          },
                        ),
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: value1,
                          onChanged: (bool? value) {
                            setState(() {
                              value1 = value!;
                            });
                          }),
                      const SizedBox(width: 10), //SizedBox
                      const Text(
                        'Completed Order',
                        style: TextStyle(fontSize: 17.0),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 100),
                  child: TextField(
                    controller: mycontroller,
                    decoration: const InputDecoration(
                      labelText: 'Enter Quantity',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ], // Only numbers can be entered
                  ),
                ),
                SizedBox(height: 250,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 40)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                              color: Colors.indigo,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Choose Pet...',
                        style: TextStyle(fontSize: 17.0, color: Colors.indigo),
                      ),
                      onPressed: () {
                        print("go to selecting a pet page");
                      },
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.symmetric(horizontal: 40)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: const BorderSide(
                              color: Colors.indigo,
                              width: 2.0,
                            ),
                          ),
                        ),
                      ),
                      child: const Text(
                        'Place Order',
                        style: TextStyle(fontSize: 17.0, color: Colors.white),
                      ),
                      onPressed: () {
                        print("Set Request for Order");
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
