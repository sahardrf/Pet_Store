import 'dart:collection';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

class tagRetrievePreview extends StatelessWidget {
  var tag;
  void Function(dynamic tag) onTapDelete;

  tagRetrievePreview(this.tag, {Key? key, required this.onTapDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Card(
          color: const Color.fromARGB(255, 224, 223, 223),
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color.fromARGB(255, 83, 83, 83),
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Row(
              children: [
                Text(
                  tag,
                  style: TextStyle(color: Colors.grey.shade800),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: GestureDetector(
                    onTap: () => onTapDelete(tag),
                    child: const CircleAvatar(
                        radius: 8,
                        backgroundColor: Color.fromARGB(255, 117, 112, 112),
                        child: Icon(
                          Icons.close,
                          size: 13,
                          color: Color.fromARGB(255, 255, 255, 255),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
