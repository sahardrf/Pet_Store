import 'package:flutter/material.dart';
import '../Search.dart';
import '../webservice/API.dart';
import '../models/pet.dart';
import 'package:pet_store/main.dart';


class Get_Pet_List extends StatefulWidget {
  String? selectedURL;
  Get_Pet_List( {this.selectedURL, Key? key }) : super(key: key);
  

  @override
  State<Get_Pet_List> createState() => _Get_Pet_ListState();
}

class _Get_Pet_ListState extends State<Get_Pet_List> {
  final String url = '';

  @override
  Widget build(BuildContext context) {
    print('GET PET LIST');
    print(widget.selectedURL);
    return MaterialApp(
      home: Center( 
    child: FutureBuilder<List<Pet>>(
        future: API.get_pets(widget.selectedURL),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Pet>? pet_data = snapshot.data;
            print(pet_data?.length);
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: (pet_data?.length == 0)? 
              AlertDialog(
                title: Text("Failed"),
                alignment: Alignment.topCenter,
                content: Text('No Pets Found. Please try different search options.'),
                actions: [
                  TextButton(
                    child: Text("OK"),
                    onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => Expanded(child: Get_Pet_List()))) ,
                  )
                ],
              )
              :ListView.builder(
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