import 'dart:developer';

import 'package:double_back_to_close/toast.dart';
import 'package:flutter/material.dart';
import 'package:pet_store/widgets/guess_game_random_card.dart';
import 'webservice/API.dart';
import 'main.dart';
import 'dart:math';
import 'utils/utils.dart';

Random random = new Random();

class Guess_Game extends StatefulWidget {
  const Guess_Game({Key? key}) : super(key: key);

  @override
  State<Guess_Game> createState() => _Guess_GameState();
}

class _Guess_GameState extends State<Guess_Game> {
  String? dropdownvalue;

  var items = ['Bunny', 'Fish', 'Hedgehog', 'Kitty', 'Puppy'];
  var dropDownIsSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Guess Game'),
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
            Padding(
              padding: EdgeInsets.all(1.0),
              child: Column(
                children: const [
                  SizedBox(height: 20),
                  Text("Guess which animal will we generate randomly"),
                  SizedBox(height: 10),
                ],
              ),
            ),
            // Text("Your Guess: " + dropdownvalue.toString()),
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
                if (dropdownvalue == null){
                setState(() {
                  dropdownvalue = newValue!;
                  dropDownIsSelected = true;
                });
                } else {
                  Toast.show("Press Remove to Play again.", context);
                }
              },
            ),
            const Padding(
                padding: EdgeInsets.all(1.0),
                child: Text("                        ")),
            (dropDownIsSelected == true)
                ? FutureBuilder<List<dynamic>>(
                    future: API.get_pets(randomly_select_URL()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<dynamic>? pet_data = snapshot.data;

                        if (dropDownIsSelected == true) {
                          var number_of_parameters = snapshot.data!.length;
                          var random_pet = random.nextInt(number_of_parameters);

                          return Random_Card(pet_data: pet_data, random_pet: random_pet,dropdownvalue: dropdownvalue);
                        }
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}");
                      }
                      return const CircularProgressIndicator();
                    },
                  )
                //check if category and dropdownvalue are equal or not
                : const Text(
                    "Please select your guess",
                    style: TextStyle(fontSize: 17, color: Colors.indigo),
                  ),
            (dropDownIsSelected == true)
                ? ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.indigo,
                    ),
                    child: const Text('Remove',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      setState(() {
                        dropDownIsSelected = false;
                        dropdownvalue = null;
                      });
                      Toast.show("Play Again!", context);
                    })
                : const Text(""),
          ],
        ),
      ),
    );
  }
}
