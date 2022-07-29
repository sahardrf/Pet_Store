import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

import 'main.dart';
import 'package:double_back_to_close/toast.dart';
import 'package:flutter/material.dart';

import 'utils/utils.dart';

class Survey_Game extends StatefulWidget {
  const Survey_Game({Key? key}) : super(key: key);

  @override
  State<Survey_Game> createState() => _Survey_GameState();
}

class _Survey_GameState extends State<Survey_Game> {
  DateTime selectedDate = DateTime.now();
  bool isSwitched = false;
  bool isDateSelected = false;
  bool value1 = false;
  bool value2 = false;
  bool value3 = false;
  int value = 0;
  int? _groupValue;
  String? dropdownvalue;
  var items = [
    'Bunny',
    'Fish',
    'Hedgehog',
    'Kitty',
    'Puppy',
    'other',
    "I don't own a pet"
  ];

  final _picker = ImagePicker();
  String? base64Image;
  String fileName = '';

  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        final bytes = File(pickedImage.path).readAsBytesSync();
        base64Image = "data:image/png;base64," + base64Encode(bytes);
        fileName = pickedImage.path.split('/').last;
        print(fileName);
      });
    }
  }

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
        title: const Text('Pet Survey Game'),
        leading: GestureDetector(
          child: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onTap: () {
            // Navigator.pop(context);
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => const HomePage(),
              ),
              (route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(children: [
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
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                  "Please Select all names below, you might consider using for your next pet:",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
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
                    'Charlie',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Checkbox(
                      value: value2,
                      onChanged: (bool? value) {
                        setState(() {
                          value2 = value!;
                        });
                      }),
                  const SizedBox(width: 10), //SizedBox
                  const Text(
                    'Buddy',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                children: [
                  Checkbox(
                      value: value3,
                      onChanged: (bool? value) {
                        setState(() {
                          value3 = value!;
                        });
                      }),
                  const SizedBox(width: 10), //SizedBox
                  const Text(
                    'Stinky',
                    style: TextStyle(fontSize: 17.0),
                  ),
                ],
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Cats or Dogs?",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ),
            ListTile(
              title: const Text("Cats"),
              leading: Radio<int>(
                groupValue: _groupValue,
                value: 0,
                onChanged: (int? value) {
                  setState(() {
                    _groupValue = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text("Dogs"),
              leading: Radio<int>(
                groupValue: _groupValue,
                value: 1,
                onChanged: (int? value) {
                  setState(() {
                    _groupValue = value;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text(
                  "None of these, let me tell you about the coolest animal!"),
              leading: Radio<int>(
                groupValue: _groupValue,
                value: 2,
                onChanged: (int? value) {
                  setState(() {
                    _groupValue = value;
                  });
                },
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("What kind of pet do you currently own?",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ),
            DropdownButton(
              hint: const Text('I own a ...'),
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
            const Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Text("Is there anything else you want to add?",
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Additional comments',
                ),
                maxLines: 2,
              ),
            ),
            Row(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text("Do you have a pet of your own?",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                  ),
                ),
                Switch(
                  value: isSwitched,
                  onChanged: (value) {
                    setState(() {
                      isSwitched = value;
                      print(isSwitched);
                    });
                  },
                  activeTrackColor: Color.fromARGB(255, 134, 141, 180),
                  activeColor: Colors.indigo,
                ),
              ],
            ),
            const SizedBox(height: 10),
            (base64Image != null)
                ? Column(
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Container(
                            decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: image(base64Image!).image,
                              fit: BoxFit.fill),
                        )),
                      ),
                      Text('$fileName'),
                      const SizedBox(height: 5),
                    ],
                  )
                : const Text(''),
            (isSwitched == true)
                ? ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(horizontal: 40)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      "Upload an image of your pet",
                      style: TextStyle(
                          color: Colors.indigo,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    ),
                    onPressed: _openImagePicker,
                  )
                : const Text('   '),
            const SizedBox(height: 30),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 40)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                "SUBMIT",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Done'),
                      content:
                          const Text('Survey has been successfully submitted.'),
                      actions: <Widget>[
                        FlatButton(
                          child: const Text('Ok'),
                          onPressed: () {
                            // Navigator.of(context).pop();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    PetStoreHomePage(),
                              ),
                              (route) => false,
                            );
                          },
                        ),
                      ],
                    );
                  },
                );
              },
            )
          ]),
        ),
      ),
    );
  }
}
