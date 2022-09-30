import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/material.dart';

var random = new Random();
Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

Image image(String thumbnail) {
  thumbnail = thumbnail.split(',').last.replaceAll("]", "");
  if (thumbnail.length % 4 > 0) {
    thumbnail += '+' * (4 - thumbnail.length % 4);
  }
  Image image = Image.memory(const Base64Decoder().convert(thumbnail));
  return image;
}

String randomly_select_URL() {
  var selectedURLID = random.nextInt(150);

  String url = '';
  if (selectedURLID <= 50) {
    url =
        'https://api.training.testifi.io/api/v3/pet/findByStatus?status=available';
  } else if (selectedURLID <= 100 && selectedURLID > 50) {
    url =
        'https://api.training.testifi.io/api/v3/pet/findByStatus?status=pending';
  } else if (selectedURLID <= 150 && selectedURLID > 100) {
    url = 'https://api.training.testifi.io/api/v3/pet/findByStatus?status=sold';
  }
  return url;
}

int set_category_id(String category_name) {
  int category_id;
  if (category_name == 'Cat' || category_name == 'cat') {
    category_id = 0;
  } else if (category_name == 'Dog' || category_name == 'dog') {
    category_id = 1;
  } else if (category_name == 'Bunny' ||
      category_name == 'bunny' ||
      category_name == 'Rabbit' ||
      category_name == 'rabbit') {
    category_id = 2;
  } else if (category_name == 'Fish' || category_name == 'fish') {
    category_id = 3;
  } else if (category_name == 'Hedgehog' || category_name == 'hedgehog') {
    category_id = 4;
  } else {
    category_id = 5;
  }
  return category_id;
}

set_tags(List tags) {
  List<dynamic> tags_json = [];
  for (int i = 0; i < tags.length; i++) {
    var temp = {"id": i, "name": tags[i]};
    tags_json.add(temp);
  }
  print(tags_json);
  return tags_json;
}

bool equalsIgnoreCase(String string1, String string2) {
  return string1?.toLowerCase() == string2?.toLowerCase();
}

bool checkCategoryInList(String string1, List list) {
  for (int i = 0; i < list.length; i++) {
    if (equalsIgnoreCase(string1, list[i])) {
      return true;
    }
  }
  return false;
}

  String checkTextField(String text){
    String checkedString;
    checkedString = text.replaceAll(" ", "");
    return checkedString;
  }

