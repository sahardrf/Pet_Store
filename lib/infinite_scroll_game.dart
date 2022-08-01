import 'dart:developer';

import 'package:double_back_to_close/toast.dart';
import 'package:flutter/material.dart';
import 'package:pet_store/widgets/guess_game_random_card.dart';
import 'webservice/API.dart';
import 'main.dart';
import 'dart:math';
import 'utils/utils.dart';

class Infinite_Scroll_Game extends StatefulWidget {
  const Infinite_Scroll_Game({ Key? key }) : super(key: key);

  @override
  State<Infinite_Scroll_Game> createState() => _Infinite_Scroll_GameState();
}

class _Infinite_Scroll_GameState extends State<Infinite_Scroll_Game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(),
    );
  }
}