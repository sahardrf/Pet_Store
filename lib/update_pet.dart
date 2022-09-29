import 'dart:convert';
import 'dart:developer';
import 'package:double_back_to_close/toast.dart';
import 'package:flutter/material.dart';
import 'package:pet_store/main.dart';
import 'package:pet_store/widgets/tag_preview.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:pet_store/widgets/tag_retrieve_preview.dart';
import 'utils/utils.dart';

class update_pet extends StatefulWidget {
  var id;
  var name;
  var status;
  var category;
  var tags;
  var photoURL;
  var number_of_photos;

  update_pet(
      {this.id, this.name, this.status, this.category, this.tags, this.photoURL, this.number_of_photos, Key? key})
      : super(key: key);

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
  TextEditingController categoryController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  late File imageFile;
  late List<dynamic> tags;
  bool isLoading = false;
  int number_of_photos=0;
  List photoURL = [];

  void initState() {
    super.initState();
    nameController.text = widget.name;
    categoryController.text = widget.category;
    tags = widget.tags.where((e) => e != null && e != "").toList();
    number_of_photos = widget.number_of_photos;
    photoURL = widget.photoURL;
      }

  void addTag() {
    if (tagController.text.isNotEmpty || tagController.text != null) {
      setState(() {
        tags.add(tagController.text);
        tagController.clear();
      });
    }
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
                            print(tags);
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 3.0),
                              child: GestureDetector(
                                  child: tagRetrievePreview(tags[index]),
                                  onTap: () {
                                    setState(() {
                                      tags.removeAt(index);
                                    });
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
                              setState(() {
                                addTag();
                              });
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
                            'Update Pet',
                            style:
                                TextStyle(fontSize: 17.0, color: Colors.white),
                          ),
                    onPressed: () async {
                      if (nameController.text.isEmpty) {
                        nameController.text = widget.name;
                      }
                      if (categoryController.text.isEmpty) {
                        categoryController.text = widget.category;
                      }
                      if (base64Image==null || base64Image == "") {
                         base64Image= widget.photoURL[0].toString();
                      }

                      if (dropdownvalue == null) {
                        dropdownvalue = widget.status;
                      }

                      print('Pressed');

                      Map data = {
                        "id": widget.id,

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
                      var response = await http.put(
                          Uri.parse(
                              "https://api.training.testifi.io/api/v3/pet"),
                          headers: {
                            "Content-Type": "application/json",
                            "Accept": "application/json"
                          },
                          body: body);
                      print(response.body);
                      print(response.statusCode);
                      if (response.statusCode == 201 ||
                          response.statusCode == 200) {
                        print('success');
                        Toast.show(
                            "Pet updated sucessfully.",
                            context, duration: 5);

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
                            context, duration: 5);
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
