import 'package:flutter/material.dart';

class Dynamic_Game_Preview extends StatelessWidget {
  String? name;

  Dynamic_Game_Preview(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color.fromARGB(255, 224, 223, 223),
      shape: RoundedRectangleBorder(
        side: const BorderSide(
          color: Color.fromARGB(255, 224, 223, 223),
        ),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:15.0, vertical: 7),
        child: Row(
          children: [
            Text(
                RemovingSpaces(name!),
                style: TextStyle(color: Colors.grey.shade800),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
    );
  }

  RemovingSpaces(String name) {
    String result = name.replaceAll(RegExp(' +'), ' ');
    return result;
  }
}
