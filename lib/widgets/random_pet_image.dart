import 'package:double_back_to_close/toast.dart';
import 'package:flutter/material.dart';
import 'package:pet_store/utils/utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'dart:developer';

class Random_Image_Card extends StatefulWidget {
  List<dynamic>? pet_data;
  int random_pet;
  int current_index = 0;
  Random_Image_Card(
      {this.pet_data, required this.random_pet, Key? key})
      : super(key: key);

  @override
  State<Random_Image_Card> createState() => _Random_Image_CardState();
}

class _Random_Image_CardState extends State<Random_Image_Card> {
  List<dynamic> photoURL = [];
  var number_of_photos;
  var selectedImage;
  

  @override
  void initState() {
    photoURL = widget.pet_data![widget.random_pet].photoUrls;
    number_of_photos = photoURL.length;
    selectedImage = random.nextInt(number_of_photos);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 180,
          width: 180,
          child: Card(
            child: Container(
              decoration: (photoURL.length != 0)
                  ? BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.center,
                          image: image(photoURL[selectedImage]).image,
                          fit: BoxFit.scaleDown),
                    )
                  : const BoxDecoration(
                      image: DecorationImage(
                          alignment: Alignment.center,
                          image: NetworkImage(
                              "https://cdn-cziplee-estore.azureedge.net//cache/no_image_uploaded-253x190.png"),
                          fit: BoxFit.scaleDown),
                    ),
              child: Text(""),
            ),
          ),
        ),
      ],
    );
  }
}
