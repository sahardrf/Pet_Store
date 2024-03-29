import 'package:flutter/material.dart';
import 'package:pet_store/main.dart';
import 'package:pet_store/Search.dart';
import '../webservice/API.dart';
import '../models/pet.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:pet_store/utils/utils.dart';
import 'dart:developer';

class Get_Pet_Cards extends StatefulWidget {
  String? selectedURL;
  Get_Pet_Cards({this.selectedURL, Key? key}) : super(key: key);

  @override
  State<Get_Pet_Cards> createState() => _Get_Pet_CardsState();
}

class _Get_Pet_CardsState extends State<Get_Pet_Cards> {

  @override
  Widget build(BuildContext context) {
    print('GET PET CARDS');
    print(widget.selectedURL);
    return Material(
        child: Center(
          child: FutureBuilder<List<dynamic>>(
            future: API.get_pets(widget.selectedURL),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<dynamic>? pet_data = snapshot.data;
                print(pet_data?.length);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (pet_data == 0)
                      ? AlertDialog(
                          title: const Text("Failed"),
                          content: const Text(
                              'No Pets Found. Please try different search options.'),
                          actions: [
                            TextButton(
                              child: const Text("OK"),
                              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Search())),
                            )
                          ],
                        )
                      : PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: pet_data!.length,
                          itemBuilder: (context, index) {
                            var id = pet_data[index].id.toString();
                            var name = pet_data[index].name.toString();
                            var category = pet_data[index].category.toString();
                            var status = pet_data[index].status.toString();
                            var photoURL = pet_data[index].photoUrls[0].toString();
                            return Card(
                              child: Container(
                                decoration: (photoURL.length !=0)? BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: image(photoURL).image,
                                      fit: BoxFit.fitWidth),
                                ): BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: NetworkImage("https://cdn-cziplee-estore.azureedge.net//cache/no_image_uploaded-253x190.png"),
                                      fit: BoxFit.fitWidth),
                                ),
                                child: Column(children: [
                                  (id==null)?Text("Null"):Text(id),
                                  const Text("         "),
                                  (name == null)? Text("Null"):
                                  Text(
                                    name,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      (category==null)?Text("Null"):
                                      Text(category),
                                      const Text(" | "),
                                      (status.isEmpty)? Text("Null"):
                                      Text(
                                        status,
                                        style: TextStyle(
                                            color: (status == 'available')
                                                ? Colors.green
                                                : (status == 'pending')
                                                    ? const Color.fromARGB(
                                                        255, 255, 174, 0)
                                                    :Colors.red),
                                      ),
                                    ],
                                  ),
                                ]),
                              ),
                            );
                          },
                        ),
                );
              }
              return const CircularProgressIndicator();
            },
          ),
        ),
      );
  }
}
