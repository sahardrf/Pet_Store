import 'package:flutter/material.dart';
import 'webservice/API.dart';
import 'main.dart';
import 'dart:math';
import 'models/pet.dart';

Random random = new Random();

class Guess_Game extends StatefulWidget {
  const Guess_Game({Key? key}) : super(key: key);

  @override
  State<Guess_Game> createState() => _Guess_GameState();
}

class _Guess_GameState extends State<Guess_Game> {
  String? dropdownvalue;

  var items = ['Bunny', 'Fish', 'Hedgehog', 'Kitty', 'Puppy'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Games'),
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
      body: Center(
        child: Column(
          children: [
            const Text("Guess Game",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Color.fromARGB(255, 40, 48, 95))),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text("Guess which animal will we generate randomly"),
            ),
            DropdownButton(
              hint: const Text("My Guess"),
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
    );
  }

  randomly_select_URL() {
    var selectedURLID = random.nextInt(150);

    String url;
    if (selectedURLID <= 50) {
      url =
          'https://api.training.testifi.io/api/v3/pet/findByStatus?status=available';
      return url;
    } else if (selectedURLID <= 100 && selectedURLID > 50) {
      url =
          'https://api.training.testifi.io/api/v3/pet/findByStatus?status=pending';
      return url;
    } else if (selectedURLID <= 150 && selectedURLID > 100) {
      url =
          'https://api.training.testifi.io/api/v3/pet/findByStatus?status=sold';
      return url;
    }
  }
}
