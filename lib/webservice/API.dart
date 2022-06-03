import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pet_store/models/pet.dart';

class API {
  String? selectedURL;

  // API(this.selectedURL);

  static Future<List<Pet>> get_pets(selectedURL) async {
    // String url = '';
    // switch (query) {
    //   case 0:
    //     url = "https://api.training.testifi.io/api/v3/pet/findByStatus?status=available";
    //     break;
    //   case 1:
    //     url = "https://api.training.testifi.io/api/v3/pet/findByStatus?status=pending";
    //     break;
    //   case 2:
    //     url = "https://api.training.testifi.io/api/v3/pet/findByStatus?status=sold";
    //     break;
    // }
    selectedURL ??=
        'https://api.training.testifi.io/api/v3/pet/findByStatus?status=available';
    // String idURL = 'https://api.training.testifi.io/api/v3/pet/';
    print('API');
    print(selectedURL);
    final response = await http.get(Uri.parse(selectedURL));

    if (response.statusCode == 200) {
      var Res = response.body;
      if ('${Res[0]}' != '[') {
        Res = '[' + response.body + ']';
      }
      List jsonResponse = json.decode(Res);
      return jsonResponse.map((pet) => new Pet.fromJson(pet)).toList();
    } else {
      return [];
    }
  }

  static Future<List> get_store_data() async {
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
