import 'package:flutter/material.dart';
import 'package:pet_store/main.dart';
import 'package:flutter/services.dart';

class Game extends StatefulWidget {
  const Game({ Key? key }) : super(key: key);

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text('Games'),
        leading: GestureDetector(
          child: Icon(
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
          children: const [
            Text("Guess Game"),
            

          
          ],
        ),
      ),
    );
      
  }
}