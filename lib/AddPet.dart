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

class add_pet extends StatefulWidget {
  const add_pet({Key? key}) : super(key: key);

  @override
  _add_petState createState() => _add_petState();
}

class _add_petState extends State<add_pet> {
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

  var random = new Random();
  String? base64Image;
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  late File imageFile;
  List<tagPreview> dynamicList = [];
  List<String> tags = [];
  bool isLoading = false;
  void initState() {
    super.initState();
    dynamicList = [];
    tags = [];
  }

  void addTag() {
    setState(() {
      tags.add(tagController.text);
      tagController.clear();
    });
  }

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
        title: const Text('Add a new pet'),
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
              Card(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      const ListTile(
                        // leading,
                        title: Text(
                          "Category",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      TextField(
                        controller: categoryController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Specify your pet's category",
                        ),
                      ),
                    ],
                  ),
                ),
                elevation: 8,
                shadowColor: Colors.grey.shade300,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white)),
              ),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const ListTile(
                        // leading,
                        title: Text(
                          "Tags",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Flexible(
                        fit: FlexFit.loose,
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: tags.length,
                          itemBuilder: (_, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3.0),
                              child: GestureDetector(
                                  child: tagPreview(tags[index]),
                                  onTap: () {
                                    tags.removeAt(index);
                                  }),
                            );
                          },
                        ),
                      ),
                      TextField(
                        controller: tagController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: "Specify your pet's tags",
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.add_circle_outline_sharp,
                              color: Color.fromARGB(255, 129, 128, 128),
                              size: 30,
                            ),
                            onPressed: () {
                              addTag();
                              print(tags);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                elevation: 8,
                shadowColor: Colors.grey.shade300,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                shape: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white)),
              ),
              Card(
                child: Column(
                  children: [
                    const ListTile(
                      title: Text(
                        "Images",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    (base64Image != null)
                        ? SizedBox(
                            width: 100,
                            height: 100,
                            child: Container(
                                decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: image(base64Image!).image,
                                  fit: BoxFit.fill),
                            )),
                          )
                        : SizedBox(
                            width: 100,
                            height: 100,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.grey.shade300,
                              ),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.grey.shade800,
                                size: 30,
                              ),
                            ),
                          ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 100),
                      child: ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                const Color.fromARGB(255, 129, 128, 128)),
                            padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(horizontal: 20)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: const BorderSide(
                                  color: Color.fromARGB(255, 129, 128, 128),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ),
                          child: const Text(
                            'Select Image',
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                          onPressed: _openImagePicker),
                    ),
                  ],
                ),
                elevation: 8,
                shadowColor: Colors.grey.shade300,
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                            'Add Pet',
                            style:
                                TextStyle(fontSize: 17.0, color: Colors.white),
                          ),
                    onPressed: () async {
                      if (nameController.text.isEmpty ||
                          categoryController.text.isEmpty ||
                          dropdownvalue! == null ||
                          tags.isEmpty) {
                        setState(() => isLoading = false);
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Error'),
                              content: Text('Please fill all the fields'),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Ok'),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        setState(() => isLoading = true);
                        print('Pressed');
                        // handle categories and tangs as list of json objects

                        Map data = {
                          "id": random.nextInt(10000),

                          ///random it integer
                          "name": nameController.text,
                          "category": {
                            "id": set_category_id(categoryController.text),
                            "name": categoryController.text,
                          },
                          "photoUrls": [base64Image],
                          "tags": set_tags(tags),
                          "status": dropdownvalue
                        };
                        var body = json.encode(data);
                        var response = await http.post(
                            Uri.parse(
                                "https://api.training.testifi.io/api/v3/pet"),
                            headers: {
                              "Content-Type": "application/json",
                              "Accept": "application/json"
                            },
                            body: body);
                        // print(response.body);
                        // print(response.statusCode);
                        if (response.statusCode == 201 ||
                            response.statusCode == 200) {
                          setState(() => isLoading = false);
                          print('success');
                          // Toast.show("Pet is successfully created.", context);
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Pet Created'),
                                content: const Text(
                                    'Pet is successfully created.'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: const Text('Ok'),
                                    onPressed: () {
                                      // Navigator.of(context).pop();
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
                                ],
                              );
                            },
                          );
                        } else {
                          setState(() => isLoading = false);
                          Toast.show(
                              "ERROR! Creating a new pet failed. Please try again.",
                              context);
                        }
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
