import 'package:double_back_to_close/toast.dart';
import 'package:flutter/material.dart';
import 'package:pet_store/utils/utils.dart';

import '../webservice/API.dart';

class Random_Image_Card extends StatefulWidget {
  const Random_Image_Card({Key? key}) : super(key: key);

  @override
  State<Random_Image_Card> createState() => _Random_Image_CardState();
}

class _Random_Image_CardState extends State<Random_Image_Card> {
  List<dynamic>? pet_data;
  int random_pet = 0;
  int current_index = 0;
  List<dynamic> photoURL = [];
  var number_of_photos;
  var selectedImage;
  var random_URL;

  @override
  Widget build(BuildContext context) {
    random_URL = randomly_select_URL();
    return FutureBuilder<List<dynamic>>(
      future: API.get_pets(random_URL),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<dynamic>? pet_data = snapshot.data;

          var number_of_parameters = snapshot.data!.length;
          var random_pet = random.nextInt(number_of_parameters);
          photoURL = pet_data![random_pet].photoUrls;
          number_of_photos = photoURL.length;
          selectedImage = random.nextInt(number_of_photos);

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
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('There was an error, Please try again'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
