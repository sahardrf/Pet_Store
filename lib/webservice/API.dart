import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_store/models/pet.dart';


class API {

// static Future <List<dynamic>> get_pets() async {
//   final response =
//       await http.get(Uri.parse("https://api.training.testifi.io/api/v3/pet/findByStatus?status=available"));
//   if (response.statusCode == 200) {
//     List jsonResponse = json.decode(response.body);
//       return jsonResponse;
//   } else {
//     throw Exception('Unexpected error occured!');
//   }
// }
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


static Future<List> get_store_data() async {
  final response =
      await http.get(Uri.parse("https://api.training.testifi.io/api/v3/store/inventory"));
  if (response.statusCode == 200) {
    Map<String, dynamic> jsonResponse = json.decode(response.body);
    String approved = jsonResponse["approved"].toString();
    String placed = jsonResponse["placed"].toString();
    String delivered = jsonResponse["delivered"].toString();
    List store_data = [{'approved': approved, 'placed': placed, 'delivered': delivered}];
    return store_data;
  } else {
    throw Exception('Unexpected error occured!');
  }
}

} 