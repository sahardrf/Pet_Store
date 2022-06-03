import 'package:flutter/material.dart';

class add_pet extends StatefulWidget {
  const add_pet({Key? key}) : super(key: key);

  @override
  _add_petState createState() => _add_petState();
}

class _add_petState extends State<add_pet> {
  TextEditingController nameController = TextEditingController();
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
      body: Center(
        child: ListView(
          children: [
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
                      controller: nameController,
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
              child: Container(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const ListTile(
                      // leading,
                      title: Text(
                        "Tags",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Specify your pets' tags",
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
                title: Text("Images"),
              ),
              elevation: 8,
              shadowColor: Colors.grey.shade300,
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white)),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 120),
              child: FlatButton(
                  child: Text(
                    'Add Pet',
                    style: TextStyle(fontSize: 17.0),
                  ),
                  color: Colors.indigo,
                  textColor: Colors.white,
                  onPressed: () {
                    print('Pressed');
                    // pass url to homepage screen
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
