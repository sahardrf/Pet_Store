import 'package:double_back_to_close/toast.dart';
import 'package:flutter/material.dart';
import 'package:pet_store/utils/utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:developer';

class Random_Card extends StatefulWidget {
  List<dynamic>? pet_data;
  String? dropdownvalue;
  int random_pet;
  int current_index = 0;
  Random_Card(
      {this.pet_data, required this.random_pet, this.dropdownvalue, Key? key})
      : super(key: key);

  @override
  State<Random_Card> createState() => _Random_CardState();
}

class _Random_CardState extends State<Random_Card> {
  final controller = PageController();
  var id;
  var name;
  var category;
  var status;
  List<dynamic> photoURL = [];
  var number_of_photos;

  @override
  void initState() {
    id = widget.pet_data![widget.random_pet].id.toString();
    name = widget.pet_data![widget.random_pet].name.toString();
    category = widget.pet_data![widget.random_pet].category.toString();
    status = widget.pet_data![widget.random_pet].status.toString();
    photoURL = widget.pet_data![widget.random_pet].photoUrls;
    number_of_photos = photoURL.length;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            if (widget.current_index < number_of_photos - 1) {
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
              Text("Your Guess:  " + widget.dropdownvalue.toString()),
              Text("Actual Pet:  " + category.toString()),
              (category == widget.dropdownvalue)
                  ? const Text("You Win!",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.green))
                  : const Text("Maybe Next Time :(",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red)),
              const Text('                       '),
              (id == null) ? const Text("Null") : Text(id),
              (name == null)
                  ? const Text("Null")
                  : Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  (category == null) ? const Text("Null") : Text(category),
                  const Text(" | "),
                  (status.isEmpty)
                      ? const Text("Null")
                      : Text(
                          status,
                          style: TextStyle(
                              color: (status == 'available')
                                  ? Colors.green
                                  : (status == 'pending')
                                      ? const Color.fromARGB(255, 255, 174, 0)
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
                decoration: (photoURL.length != 0)
                    ? BoxDecoration(
                        image: DecorationImage(
                            alignment: Alignment.bottomCenter,
                            image: image(photoURL[widget.current_index]).image,
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
            count: number_of_photos,
            effect: ExpandingDotsEffect(),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
