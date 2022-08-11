import 'dart:convert';
import 'package:double_back_to_close/toast.dart';
import 'package:flutter/material.dart';
import 'package:pet_store/main.dart';
import 'package:pet_store/widgets/tag_preview.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'utils/utils.dart';

class update_pet extends StatefulWidget {
  var id;
  var name;
  var status;

  update_pet({this.id, this.name, this.status, Key? key}) : super(key: key);

  @override
  _update_petState createState() => _update_petState();
}

class _update_petState extends State<update_pet> {
  final _picker = ImagePicker();
  Future<void> _openImagePicker() async {
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        final bytes = File(pickedImage.path).readAsBytesSync();
        base64Image = "data:image/png;base64," + base64Encode(bytes);
      });
    }
  }

  String? base64Image;
  TextEditingController nameController = TextEditingController();

  late File imageFile;

  bool isLoading = false;

  String? dropdownvalue;

  var items = [
    'available',
    'pending',
    'sold',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Update a pet'),
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Card(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const ListTile(
                        // leading,
                        title: Text(
                          "General Information",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Enter your pet's name",
                        ),
                      ),
                      DropdownButton(
                        hint: const Text('Select Status'),
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
                    ],
                  ),
                ),
                elevation: 8,
                shadowColor: Colors.grey.shade300,
                margin: const EdgeInsets.all(20),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white)),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 120),
                child: ElevatedButton(
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
                    child: isLoading
                        ? const SizedBox(
                            child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white)),
                            height: 15.0,
                            width: 15.0,
                          )
                        : const Text(
                            'Update Pet',
                            style:
                                TextStyle(fontSize: 17.0, color: Colors.white),
                          ),
                    onPressed: () async {
                      if (nameController.text.isEmpty) {
                        nameController.text = widget.name;
                      }
                      if (dropdownvalue == null) {
                        dropdownvalue = widget.status;
                      }
                      print('Pressed');
                     
                      var response = await http.post(Uri.parse(
                          "https://api.training.testifi.io/api/v3/pet/" +
                              widget.id +
                              "?" +
                              "name=${nameController.text}" +
                              "&status=${dropdownvalue}"));

                      print(response.body);
                      print(response.statusCode);
                      if (response.statusCode == 201 ||
                          response.statusCode == 200) {
                        print('success');
                        Toast.show("Pet is successfully updated.", context);

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) =>
                                PetStoreHomePage(LoggedIn: true),
                          ),
                          (route) => false,
                        );
                      } else {
                        Toast.show(
                            "ERROR! Updating pet failed. Please try again.",
                            context);
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
