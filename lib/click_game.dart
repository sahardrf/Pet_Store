import 'package:flutter/material.dart';
import 'main.dart';

class Click_Game extends StatefulWidget {
  const Click_Game({Key? key}) : super(key: key);

  @override
  State<Click_Game> createState() => _Click_GameState();
}

class _Click_GameState extends State<Click_Game> {
  bool isDoubled = false;
  bool isLongPressed = false;
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: const Text('Click Game'),
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
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: (isTapped == false &&
                    isDoubled == false &&
                    isLongPressed == false)
                ? MaterialStateProperty.all(Color.fromARGB(255, 76, 74, 74))
                : MaterialStateProperty.all(Colors.indigo),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 60, vertical: 30)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
                side: BorderSide(
                  color: (isTapped == false &&
                          isDoubled == false &&
                          isLongPressed == false)
                      ? const Color.fromARGB(255, 76, 74, 74)
                      : Colors.indigo,
                  width: 2.0,
                ),
              ),
            ),
          ),
          child: GestureDetector(
            child: (isTapped == true)
                ? const Text('Single Clicked',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold))
                : (isDoubled == true)
                    ? const Text('Double Clicked',
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold))
                    : (isLongPressed == true)
                        ? const Text('Long Clicked',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold))
                        : const Text('Unclicked',
                            style: TextStyle(
                                fontSize: 17, fontWeight: FontWeight.bold)),
            onDoubleTap: () {
              setState(() {
                isDoubled = true;
                isLongPressed = false;
                isTapped = false;
              });
            },
            onLongPress: () {
              setState(() {
                isLongPressed = true;
                isDoubled = false;
                isTapped = false;
              });
            },
          ),
          onPressed: () {
            setState(() {
              isTapped = true;
              isDoubled = false;
              isLongPressed = false;
            });
          },
        ),
      ),
    );
  }
}
