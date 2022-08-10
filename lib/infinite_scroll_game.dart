import 'package:flutter/material.dart';
import 'package:pet_store/utils/utils.dart';
import 'package:pet_store/widgets/random_pet_image.dart';
import 'webservice/API.dart';

import 'main.dart';

class Infinite_Scroll_Game extends StatefulWidget {
  const Infinite_Scroll_Game({Key? key}) : super(key: key);

  @override
  State<Infinite_Scroll_Game> createState() => _Infinite_Scroll_GameState();
}

class _Infinite_Scroll_GameState extends State<Infinite_Scroll_Game> {
  ScrollController _scrollController = ScrollController();
  int pageNumber = 1;

  var myRecipe;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        pageNumber++;
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Infinite Scroll Game'),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        child: FutureBuilder<List<dynamic>>(
          future: API.get_pets(randomly_select_URL()),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<dynamic>? pet_data = snapshot.data;
              var number_of_parameters = snapshot.data!.length;
              var random_pet = random.nextInt(number_of_parameters);
              return GridView.builder(
                controller: _scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return Random_Image_Card(
                        pet_data: pet_data, random_pet: random_pet);
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('There was an error, Please try again'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
