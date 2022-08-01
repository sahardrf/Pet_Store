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
