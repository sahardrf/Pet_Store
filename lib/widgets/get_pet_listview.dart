import 'package:flutter/material.dart';
import '../webservice/API.dart';
import '../models/pet.dart';

class Get_Pet_List extends StatelessWidget {

  const Get_Pet_List({ Key? key }) : super(key: key);

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
              child: ListView.builder(
                itemCount: pet_data?.length,
                itemBuilder: (context, index) {
                  var id = pet_data![index].id.toString();
                  var name = pet_data[index].name.toString();
                  var category = pet_data[index].category.toString();
                  var status = pet_data[index].status.toString();
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                      color: Colors.indigo,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      leading: Text(id),
                      title: Text(name, style: const TextStyle(fontWeight: FontWeight. bold),),
                      subtitle: Row(children: [Text(category),const Text(" | "), Text(status,
                       style: TextStyle(color: (status == 'available')? Colors.green: (status == 'pending')? const Color.fromARGB(255, 255, 174, 0): Colors.red),
                       ),
                       ],
                       ),
                      ),
                      // trailing: Text(Category),
                    // ),
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