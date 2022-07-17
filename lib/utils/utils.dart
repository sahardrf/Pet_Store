  import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

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