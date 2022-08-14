import 'dart:developer';
import 'package:double_back_to_close/toast.dart';
import 'package:flutter/material.dart';
import 'package:pet_store/update_pet.dart';
import 'package:pet_store/utils/utils.dart';
import 'package:pet_store/webservice/API.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'main.dart';
import 'package:http/http.dart' as http;

class Pet_Info extends StatefulWidget {
  var id;
  var name;
  var category;
  var status;
  var tags;
  List<dynamic> photoURL;
  var number_of_photos;
  int current_index = 0;

  Pet_Info(
      {this.id,
      this.name,
      this.category,
      this.status,
      required this.photoURL,
      this.number_of_photos,
      this.tags,
      Key? key})
      : super(key: key);

  @override
  State<Pet_Info> createState() => _Pet_InfoState();
}

class _Pet_InfoState extends State<Pet_Info> {
  final controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: const Text('Pet Info'),
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
        body: Column(
          children: [
            SizedBox(height: 80),

            // SizedBox(height: 30),
            GestureDetector(
              onPanUpdate: (details) {
                if (details.delta.dx > 2) {
                  setState(() {
                    if (0 < widget.current_index) {
                      widget.current_index--;
                    }
                  });
                }
                if (details.delta.dx < -2) {
                  setState(() {
                    if (widget.current_index < widget.number_of_photos - 1) {
                      widget.current_index++;
                    }
                  });
                }
              },
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    child: Column(children: [
                      (widget.name == null)
                          ? const Text("Null")
                          : Text(
                              widget.name,
                              style: const TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          (widget.category == null)
                              ? const Text("Null")
                              : Text(widget.category,
                                  style: TextStyle(fontSize: 17)),
                          const Text(" | "),
                          (widget.status.isEmpty)
                              ? const Text("Null")
                              : Text(
                                  widget.status,
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: (widget.status == 'available')
                                          ? Colors.green
                                          : (widget.status == 'pending')
                                              ? const Color.fromARGB(
                                                  255, 255, 174, 0)
                                              : Colors.red),
                                ),
                        ],
                      ),
                    ]),
                  ),
                  SizedBox(
                    height: 250,
                    width: 250,
                    child: Card(
                      child: Container(
                        decoration: (widget.photoURL.length != 0)
                            ? BoxDecoration(
                                image: DecorationImage(
                                    alignment: Alignment.bottomCenter,
                                    image: image(widget
                                            .photoURL[widget.current_index])
                                        .image,
                                    fit: BoxFit.cover),
                              )
                            : const BoxDecoration(
                                image: DecorationImage(
                                    alignment: Alignment.bottomCenter,
                                    image: NetworkImage(
                                        "https://cdn-cziplee-estore.azureedge.net//cache/no_image_uploaded-253x190.png"),
                                    fit: BoxFit.scaleDown),
                              ),
                        child: Text(""),
                      ),
                    ),
                  ),
                  AnimatedSmoothIndicator(
                    activeIndex: widget.current_index,
                    count: widget.number_of_photos,
                    effect: ExpandingDotsEffect(),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 255, 255, 255)),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(horizontal: 40)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
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
                          'Update Pet',
                          style:
                              TextStyle(fontSize: 17.0, color: Colors.indigo),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => update_pet(
                                id: widget.id,
                                name: widget.name,
                                status: widget.status,
                                category: widget.category,
                                tags: widget.tags,
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white),
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(horizontal: 40)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                color: Color.fromARGB(255, 192, 38, 27),
                                width: 2.0,
                              ),
                            ),
                          ),
                        ),
                        child: const Text(
                          'Delete Pet',
                          style: TextStyle(
                              fontSize: 17.0,
                              color: Color.fromARGB(255, 192, 38, 27)),
                        ),
                        onPressed: () async {
                          String delete_URL =
                              'https://api.training.testifi.io/api/v3/pet/' +
                                  widget.id;
                          final response = await http.delete(
                              Uri.parse(delete_URL),
                              headers: {"Content-type": "application/json"});
                          if (response.statusCode == 204) {
                            Toast.show("Pet deleted.", context);
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const HomePage(),
                              ),
                              (route) => false,
                            );
                          } else {
                            Toast.show("ERROR! deleting pet failed.", context);
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
