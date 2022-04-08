import 'package:flutter/material.dart';
import '../API.dart';

class Get_Pet_List extends StatelessWidget {
  const Get_Pet_List({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Center( 
    child: FutureBuilder<List<dynamic>>(
        future: API.get_pets(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  var id = snapshot.data![index]['id'].toString();
                  var name = snapshot.data![index]['name'].toString();
                  var category = snapshot.data![index]['category']['name'].toString();
                  return Card(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                      color: Colors.indigo,
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: ListTile(
                      leading: Text(id),
                      title: Text(name),
                      subtitle: Text(category)
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