import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_store/pet.dart';


class API {

static Future <List<dynamic>> get_pets() async {
  final response =
      await http.get(Uri.parse("https://api.training.testifi.io/api/v3/pet/findByStatus?status=available"));
  if (response.statusCode == 200) {
    print("INTO API");
    return json.decode(response.body);
    // List jsonResponse = json.decode(response.body)['name'];
      // return jsonResponse.map((pet) => new Pet.fromJson(pet)).toList();
  } else {
    throw Exception('Unexpected error occured!');
  }
}
} 