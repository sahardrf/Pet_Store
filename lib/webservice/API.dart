import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_store/models/pet.dart';


class API {

static Future <List<Pet>> get_pets() async {
  final response =
      await http.get(Uri.parse("https://api.training.testifi.io/api/v3/pet/findByStatus?status=available"));
  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
      return jsonResponse.map((pet) => new Pet.fromJson(pet)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}

} 