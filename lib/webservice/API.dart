import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_store/models/pet.dart';

class API {
  String? selectedURL;
  static Future<List<dynamic>> get_pets(selectedURL) async {
    selectedURL ??=
        'https://api.training.testifi.io/api/v3/pet/findByStatus?status=available';
    print('API');
    print(selectedURL);
    final response = await http.get(Uri.parse(selectedURL));

    if (response.statusCode == 200) {
      var Res = response.body;
      if ('${Res[0]}' != '[') {
        Res = '[' + response.body + ']';
      }
      List jsonResponse = json.decode(Res);
      List<Pet> pets = jsonResponse.map((pet) => new Pet.fromJson(pet)).toList();
      // final images = (jsonResponse[0]['photoUrl'] ?? []) as List<dynamic>;
      // List pets_info = [{
      //   'pets': pets,
      //   // 'images': images,
      // }];
      return pets;
    } else {
      return [];
    }
  }

  static Future<List> Get_Store_Active_Orders() async {
    final response = await http.get(
        Uri.parse("https://api.training.testifi.io/api/v3/store/inventory"));
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      String approved = jsonResponse["approved"].toString();
      String placed = jsonResponse["placed"].toString();
      String delivered = jsonResponse["delivered"].toString();
      List store_data = [
        {'approved': approved, 'placed': placed, 'delivered': delivered}
      ];
      return store_data;
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
