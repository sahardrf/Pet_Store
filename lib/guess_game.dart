import 'package:double_back_to_close/toast.dart';
import 'package:flutter/material.dart';
import 'webservice/API.dart';
import 'main.dart';
import 'dart:math';
import 'models/pet.dart';
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
              padding: EdgeInsets.all(1.0),
              child: Text("Guess which animal will we generate randomly"),
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
                setState(() {
                  dropdownvalue = newValue!;
                  dropDownIsSelected = true;
                });
              },
            ),
            //get pets and show one of them randomly
            const Padding(
                padding: EdgeInsets.all(1.0),
                child: Text("                        ")),
            (dropDownIsSelected == true)
                ? FutureBuilder<List<Pet>>(
                    future: API.get_pets(randomly_select_URL()),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        if (dropDownIsSelected == true) {
                          var number_of_parameters = snapshot.data!.length;
                          var random_pet = random.nextInt(number_of_parameters);
                          return Expanded(
                            child: PageView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: number_of_parameters,
                              onPageChanged: (int index) {
                                setState(() {
                                  dropdownvalue = null;
                                  dropDownIsSelected = false;
                                });
                              },
                              itemBuilder: (context, index) {
                                Pet pet = snapshot.data![random_pet];
                                var id = pet.id.toString();
                                var name = pet.name.toString();
                                var category = pet.category.toString();
                                var status = pet.status.toString();
                                var photoURL = pet.photoUrls.toString();
                                return Card(
                                  child: Container(
                                    width: 100,
                                    height: 150,
                                    decoration: (photoURL.length >= 50)
                                        ? BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: DecorationImage(
                                                opacity: 0.6,
                                                image: image(photoURL).image,
                                                fit: BoxFit.scaleDown),
                                          )
                                        : BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            image: const DecorationImage(
                                                opacity: 0.6,
                                                image: NetworkImage(
                                                    "https://cdn-cziplee-estore.azureedge.net//cache/no_image_uploaded-253x190.png"),
                                                fit: BoxFit.scaleDown),
                                          ),
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      child: Column(children: [
                                        Text("Your Guess:  " +
                                            dropdownvalue.toString()),
                                        Text("Actual Pet:  " +
                                            category.toString()),
                                        (category == dropdownvalue)
                                            ? const Text("You Win!",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.green))
                                            : const Text("Maybe Next Time :(",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red)),
                                        const Text('                       '),
                                        (id == null)
                                            ? const Text("Null")
                                            : Text(id),
                                        (name == null)
                                            ? const Text("Null")
                                            : Text(
                                                name,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            (category == null)
                                                ? const Text("Null")
                                                : Text(category),
                                            const Text(" | "),
                                            (status.isEmpty)
                                                ? const Text("Null")
                                                : Text(
                                                    status,
                                                    style: TextStyle(
                                                        color: (status ==
                                                                'available')
                                                            ? Colors.green
                                                            : (status ==
                                                                    'pending')
                                                                ? const Color
                                                                        .fromARGB(
                                                                    255,
                                                                    255,
                                                                    174,
                                                                    0)
                                                                : Colors.red),
                                                  ),
                                          ],
                                        ),
                                      ]),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
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
              (dropDownIsSelected==true)? ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.indigo,
                    
                  ),
                  child: const Text('Remove', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    setState(() {
                                          dropDownIsSelected = false;
                    dropdownvalue = null;
                    });
                    Toast.show("Play Again!", context);
                  }):const Text(""),
          ],
        ),
      ),
    );
  }
}
