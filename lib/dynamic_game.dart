import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:pet_store/widgets/dynamic_game_preview.dart';
import 'main.dart';

class Dynamic_Game extends StatefulWidget {
  const Dynamic_Game({Key? key}) : super(key: key);

  @override
  State<Dynamic_Game> createState() => _Dynamic_GameState();
}

class _Dynamic_GameState extends State<Dynamic_Game> {
  TextEditingController nameController = TextEditingController();
  List<String> names = [];
  bool isLoading = false;
    List<Dynamic_Game_Preview> dynamicList = [];
  void initState() {
    super.initState();
    dynamicList = [];
    names = [];
  }

  void addNames() {
    setState(() {
      names.add(nameController.text);
      nameController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Dynamic Game'),
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
        child: Column(children: <Widget>[
          SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    labelText: 'Enter a Pet Name',
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.indigo),
                padding: MaterialStateProperty.all(
                    const EdgeInsets.symmetric(horizontal: 40)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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
                'GO!',
                style: TextStyle(fontSize: 17.0, color: Colors.white),
              ),
              onPressed: () {
                addNames();
              },
            ),
            Flexible(
                      fit: FlexFit.loose,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: names.length,
                        itemBuilder: (_, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 5.0, vertical: 3.0),
                            child: Dynamic_Game_Preview(names[index]),
                          );
                        },
                      ),
                    ),
            ],
          ),
      ),
    );
  }
}
