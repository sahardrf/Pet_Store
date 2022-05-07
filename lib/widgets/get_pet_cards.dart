import 'package:flutter/material.dart';
import '../webservice/API.dart';
import '../models/pet.dart';
import 'dart:convert';
import 'dart:typed_data';


Image image(String thumbnail) {
        thumbnail = thumbnail.split(',').last.replaceAll("]", ""); 
          if (thumbnail.length % 4 > 0) { 
              thumbnail += '+' * (4 - thumbnail .length % 4); 
          }
        Image image = Image.memory(Base64Decoder().convert(thumbnail));
        return image;
      }


class Get_Pet_Cards extends StatelessWidget {

  const Get_Pet_Cards({ Key? key }) : super(key: key);
  
Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center( 
    child: FutureBuilder<List<Pet>>(
        future: API.get_pets(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Pet>? pet_data = snapshot.data;
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: pet_data?.length,
                itemBuilder: (context, index) {
                  var id = pet_data![index].id.toString();
                  var name = pet_data[index].name.toString();
                  var category = pet_data[index].category.toString();
                  var status = pet_data[index].status.toString();
                  var photoURL = pet_data[index].photoUrls.toString();
                  return Card(
                    child:Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        image: DecorationImage(
                          image: image(photoURL).image,
                          fit:BoxFit.fitWidth
                        ),
                      ),
                      child: Column(children: [
                        Text(id),
                        const Text("         "),
                        Text(name, style: const TextStyle(fontWeight: FontWeight. bold),),
                        Row(mainAxisAlignment: MainAxisAlignment.center, 
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [Text(category),const Text(" | "), 
                          Text(status, style: TextStyle(color: (status == 'available')? Colors.green: (status == 'pending')? const Color.fromARGB(255, 255, 174, 0): Colors.red),
                        ),
                        ],
                        ),
                      ]),
                    ),
                    );
                },
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    ), 
    );
  }
}