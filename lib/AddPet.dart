import 'package:flutter/material.dart';
import 'package:pet_store/widgets/tag_preview.dart';

class add_pet extends StatefulWidget {
  const add_pet({Key? key}) : super(key: key);

  @override
  _add_petState createState() => _add_petState();
}

class _add_petState extends State<add_pet> {
  TextEditingController nameController = TextEditingController();
  TextEditingController categoryController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  List<tagPreview> dynamicList = [];
  List<String> tags = [];
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
    'Available',
    'Pending',
    'Sold',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Add a new pet'),
      ),
      body: SingleChildScrollView(
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
                        labelText: 'Name',
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
                        labelText: "Specify your pets' category",
                      ),
                    ),
                  ],
                ),
              ),
              elevation: 8,
              shadowColor: Colors.grey.shade300,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                              child: GestureDetector(child: tagPreview(tags[index]),
                              onTap: (){
                                tags.removeAt(index);
                              }
                              ),
                            );
                          },
                         ),
                    ),
                    TextField(
                      controller: tagController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Specify your pets' tags",
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.add_circle_outline_sharp,
                            color: Color.fromARGB(255, 129, 128, 128),
                            size: 30,
                          ),
                          onPressed: () {
                            addTag();
                            print(tags);
                            print('add tags');
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              elevation: 8,
              shadowColor: Colors.grey.shade300,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white)),
            ),
            Card(
              child: const ListTile(
                title: Text(
                  "Images",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              elevation: 8,
              shadowColor: Colors.grey.shade300,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                child: const Text(
                  'Add Pet',
                  style: TextStyle(fontSize: 17.0, color: Colors.white),
                ),
                onPressed: () {
                  print('Pressed');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

